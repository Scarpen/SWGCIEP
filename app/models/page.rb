class Page < ActiveRecord::Base
	has_many :menus, :dependent => :destroy
	belongs_to :user
	accepts_nested_attributes_for :menus, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
end
