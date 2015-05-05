class Menu < ActiveRecord::Base
	belongs_to :menu, :as => :father
	has_many :menu, :as => :submenu, :dependent => :destroy
	belongs_to :page
	has_many :photo, :dependent => :destroy
	has_one :text, :dependent => :destroy
end
