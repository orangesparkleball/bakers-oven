class Page
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :title, String
  property :page_number, String
  property :subtitle, String
  property :body, Text
  belongs_to :book
  belongs_to :cover_image, :model => 'Upload', :required => false

  def cover_image_path(export = false)
    if export
      self.cover_image.file.to_s.gsub(/^\//, '')
    else
      self.cover_image.file.to_s
    end
  end
end
