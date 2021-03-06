class Menu < ActiveRecord::Base
	has_many :submenus, :class_name => "Menu", :foreign_key => "father_id", :dependent => :destroy
  	belongs_to :father, :class_name => "Menu"
	belongs_to :page
	has_many :photos, :dependent => :destroy
	has_one :text, :dependent => :destroy
  	accepts_nested_attributes_for :submenus, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  	accepts_nested_attributes_for :text, :allow_destroy => true
  	accepts_nested_attributes_for :photos, :allow_destroy => true
end
