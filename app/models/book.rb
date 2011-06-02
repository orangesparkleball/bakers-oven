require 'zip/zip'
require 'zip/zipfilesystem'

class Book
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  
  property :title, String, :length => 255
  property :author, String, :length => 255
  property :creator, String, :length => 255
  has n, :uploads
  has n, :pages
  
  def to_hpub
    self.to_tmp
    system "cd tmp/book; zip -r my_book *"
    unless File.directory?('pkg')
      puts "making dir : "+'pkg'
      FileUtils.mkdir_p('pkg')
    end

    system "cp tmp/book/my_book.zip pkg/#{self.title}.hpub"
    "pkg/#{self.title}.hpub"
  end
  def to_tmp
    @faker = Rack::MockRequest.new(Padrino.application)
    prep_tmp_book

    self.uploads.each do |u|
      system "cp #{u.file.to_s.gsub(/^\//, 'public/')} tmp/book/uploads/images"
    end

    self.pages.each do |p|
      file = p.page_number + ".html"
      rack_url = "/book_export/#{p.book.id}/page/#{p.page_number}"
      File.open('tmp/book/'+file, 'w'){ |f| f.print @faker.get(rack_url).body}
    end
  end

  def prep_tmp_book
    system "rm -rf tmp/book"

    unless File.directory?('tmp/book')
      puts "making dir : "+'tmp/book'
      FileUtils.mkdir_p('tmp/book/uploads/images')
    end
    
    system "sass --update app/stylesheets:public/stylesheets -t compact"
    system "cp -R public/images tmp/book/"
    system "cp -R public/stylesheets tmp/book/"
    system "cp -R public/javascripts tmp/book/"
    system "cp -R public/videos tmp/book/"
    
  end
end
