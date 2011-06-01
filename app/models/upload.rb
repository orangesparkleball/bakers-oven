require 'carrierwave/orm/datamapper'
class Upload
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :file, Text, :auto_validation => false
  property :created_at, DateTime
   mount_uploader :file, Uploader
  belongs_to :book
end
