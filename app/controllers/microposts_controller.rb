class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
	@micropost = current_user.microposts.build(micropost_params)
	     
	if @micropost.trigger == 1
	User.update_all("leave = 1" , :id => current_user )

	temp = Overtime.find(:all,:conditions => ["id =?", current_user.designation_id])

	Overtime.update_all("ot = ot + 8",:id => temp)

	temp_user=User.find(:all,:conditions => ["designation = ?", current_user.designation])
	User.update_all("visible = 1","leave == 0" && :id => temp_user)
	User.update_all("visible = 0",:id => current_user)

	else

	temp = Overtime.find(:all,:conditions => ["id =?", current_user.designation_id])
	Overtime.update_all("ot = ot - 2","ot >= 0" && :id => temp)
	User.update_all("visible = 0",:id => current_user)

	User.update_all("workhour = workhour + 2" , :id => current_user )
	User.update_all("leave = 2" , :id => current_user )
	end
    
    if @micropost.save
      flash[:success] = "Action Performed!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :trigger)
    end
  
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
