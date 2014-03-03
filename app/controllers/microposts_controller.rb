class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
 	@micropost = current_user.microposts.build(micropost_params)

        if @micropost.trigger == 1
	User.update_all("leave = 11,overtime_count = 2" , :id => current_user )

	temp = Overtime.find(:all,:conditions => ["id =?", current_user.designation_id])
	Overtime.update_all("ot = ot + 2",:id => temp)

	temp_user=User.find(:all,:conditions => ["designation = ?", current_user.designation])
	User.where(:id => temp_user).where("leave == 0").where("overtime_count == 0").update_all("visible = 1")
	User.update_all("visible = 0",:id => current_user)

	else if @micropost.trigger == 0
	overtime = Overtime.find_by_sql("Select o.ot, o.id from overtimes o , users u where o.id = u.designation_id limit 1")
	if overtime.first.ot != 0
	temp = Overtime.find(:all,:conditions => ["id =?", current_user.designation_id])
	Overtime.where(:id => temp).update_all("ot = ot - 2")
	User.update_all("visible = 0,overtime_count = 11",:id => current_user)

	User.update_all("leave = 2" , :id => current_user )
	else 
	temp = Overtime.find(:all,:conditions => ["id =?", current_user.designation_id])
	@micropost.destroy
	User.update_all("visible = 0",:id => temp)
	User.update_all("visible = 2", :id => current_user )
	end
	else 
	User.update_all("visible = 0", :id => current_user )
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
