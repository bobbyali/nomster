class Photo < ActiveRecord::Base
  belongs_to :places
  mount_uploader :picture, PictureUploader
end
