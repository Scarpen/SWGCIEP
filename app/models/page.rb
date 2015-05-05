class Page < ActiveRecord::Base
	has_many :menu, :dependent => :destroy
	belongs_to :user
end
