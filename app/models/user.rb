class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :role
  has_one :page, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

def self.search(search_column, search)   
    if search
        col = "#{search_column} "
        s = "%#{search}%"

        where("#{col} like ?", s)  
    else  
        scoped   
    end  
end
def self.searchint(search_column, search)   
    if search
        col = "#{search_column} "
        s = "%#{search}%"
        where("#{col} = ?", s)   
    else  
        scoped   
    end  
end
end