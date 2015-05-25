class Page < ActiveRecord::Base
	mount_uploader :logo, LogoUploader
	mount_uploader :header, HeaderUploader
	has_many :menus, :dependent => :destroy
	belongs_to :user
	has_many :comments, :dependent => :destroy
	accepts_nested_attributes_for :menus, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
	
end
