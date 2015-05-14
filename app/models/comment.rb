
class Comment < ActiveRecord::Base
	has_many :responds, :class_name => "Comment", :foreign_key => "father_id", :dependent => :destroy
  	belongs_to :father, :class_name => "Comment"
belongs_to :page

end
