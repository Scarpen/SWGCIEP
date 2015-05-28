class HomeController < ApplicationController

	def index 
		@pages = Page.order(recommends: :desc)
	end


end
