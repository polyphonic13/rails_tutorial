class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy
  
  def create
    #puts "------------------- ATTEMPTING TO CREATE A MICROPOST WITH #{params[:micropost]}"
    # @micropost = current_user.microposts.build(params[:micropost])
    # if @micropost.save 
    #   flash[:success] = "Micropost created!"
    #   redirect_to root_url
    # else
    #   @feed_items = []
    #   render 'static_pages/home'
    # end
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_url
  end
  
  private
  
    def current_user
      @micropost = current_user.microposts.find_by_id(params[:id])
    rescue
      redirect_to root_url if @micropost.nil?
    end
end