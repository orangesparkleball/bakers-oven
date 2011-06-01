class Book
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  
  property :title, String, :length => 255
  property :author, String, :length => 255
  property :creator, String, :length => 255
  has n, :uploads
  has n, :pages
  
end
