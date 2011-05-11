desc "save static html to 'static' directory..."
task :build do

  require 'rake'
  require File.dirname(__FILE__)+'/config/boot.rb'

  @request = Rack::MockRequest.new(Padrino.application)
  haml_view_paths = Dir.glob('app/views/pages/**/*.haml').map {|path| path[0..-6].sort_by {|view| view.length } }

  def create_dirs static_view_path

    dir = File.dirname(static_view_path)

    unless File.directory?(dir)
      puts "making dir : "+dir
      FileUtils.mkdir_p(dir)
    end

  end
  

  def create_files rack_url, static_view

    if rack_url.include? "index"
      index_url = rack_url.sub('index','')
      puts "creating "+static_view +".html"
      File.open(static_view+".html", 'w'){|f| f.print @request.get(index_url+'index.html').body}
    elsif rack_url.include? "00"
      index_url = static_view.sub('cover','00')
      puts "creating "+static_view +".html"
      File.open(index_url+".html", 'w'){|f| f.print @request.get(rack_url+'.html').body}
      
    else
      puts "creating "+static_view +".html"
      File.open(static_view+".html", 'w'){|f| f.print @request.get(rack_url+'.html').body}
    end
  end

  haml_view_paths.each do |haml_path|

    static_view_path = haml_path.to_s.sub(/app\/views\/pages/,'book')
    rack_url = haml_path.to_s.sub(/app\/views\/pages/,'')
    rack_url = '/00' if rack_url == '/cover'
    create_dirs(static_view_path)
    create_files(rack_url, static_view_path)

  end
  system "sass --update app/stylesheets:public/stylesheets -t compact"
  system "cp -R public/* book/"

end


desc "clean out book"
task :clean do
  system "rm -rf book/*"
  system "rm -rf pkg/*"
end

desc "compile a fresh book"
task :compile => [:clean, :build] do
  puts "Zipping file"
  system "cd book; zip -r my_book *"
  unless File.directory?('pkg')
    puts "making dir : "+'pkg'
    FileUtils.mkdir_p('pkg')
  end

  system "cp book/my_book.zip pkg/my_book.hpub"
  puts "book in pkg"
end

desc "deploy latest book"
task :deploy => :compile do
  # puts "rsync -rtz  pkg/ username@server:~/path/to/books/"
  # system "rsync -rtz  pkg/ username@server:~/path/to/books/"
end
