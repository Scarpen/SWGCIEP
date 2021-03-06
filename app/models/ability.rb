class Ability
  include CanCan::Ability

  def initialize(user)
    if user ||= User.new
        can :read, [Page]
        can :read, [Menu]
        can :read, [Photo]
        can :read, [Text]
    end
    if user.role.name == "admin"
        can :manage, :all
    elsif user.role.name == "institute"
        can :read, [User]
        can :create, [Menu]
        can :create, [Photo]
        can :create, [Text]
        can :manage, [Page], :user_id => user.id
        can :manage, Menu do |menu|
            menu.try(:page_id) == user.page.id
        end
        can :manage, Photo do |photo|
            user.page.menus do menu
                photo.try(:menu_id) == menu.id
            end
        end
        can :manage, Text do |text|
            user.page.menus do menu
                text.try(:menu_id) == menu.id
            end
        end
    end
        
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
