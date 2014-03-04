class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
 	@micropost = current_user.microposts.build(micropost_params)
	
	check = 0

	if @micropost.trigger == 1
		User.update_all("leave = 11,overtime_count = 2" , :id => current_user )

		Overtime.update_all("ot = ot + 2",:id => current_user.designation_id)

		temp_user=User.find(:all,:conditions => ["designation = ?", current_user.designation])
		User.where(:id => temp_user).where("leave == 0").where("overtime_count == 0").update_all("visible = 1")
		User.update_all("visible = 0",:id => current_user)

		@micropost.save
		flash[:success] = "Leave taken!"
		

	else
		if params[:commit] == "Accept"
	
			overtime = Overtime.find_by_sql ["SELECT o.ot,o.id FROM overtimes o,users u WHERE o.id = u.designation_id LIMIT 1"]

			if overtime.first.ot != 0
				Overtime.where(:id => current_user.designation_id).update_all("ot = ot - 2")
				User.update_all("visible = 0,overtime_count = 1",:id => current_user)
				User.update_all("leave = 2" , :id => current_user )

				@micropost.save
				flash[:success] = "Overtime allocated!"
			else
				check = 1
				@micropost.destroy

				flash[:success] = "Overtime not available!"	

				temp_user=User.find(:all,:conditions => ["designation = ?", current_user.designation])
				User.where(:id => temp_user).update_all("visible = 0")
				User.update_all("visible = 2", :id => current_user)
	
			end
		else params[:commit] == "Reject"
			check = 1
			@micropost.destroy
			flash[:success] = "Overtime rejected!"
		
			User.update_all("visible = 0", :id => current_user)
		end
	end
	redirect_to root_url
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost,).permit(:content, :trigger)
    end
  
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
