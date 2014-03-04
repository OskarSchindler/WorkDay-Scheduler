namespace :db do
  desc "Update Workhours"
  task updatewh: :environment do
    incr_workhour
  end
end


  def incr_workhour
	
	User.where(" leave != 10 ").update_all("workhour = workhour + 8")
	User.where(" leave == 10 ").update_all("leave = 0")
	User.where(" leave == 2 ").update_all("leave = 0")
	User.where(" leave == 11 ").update_all("leave = 10")

	User.update_all("ideal_workhour = ideal_workhour + 8")

	User.where("overtime_count == 10").update_all("workhour = workhour + 2" )
	User.where("overtime_count == 10").update_all("overtime_count = 0" )
	User.where("overtime_count == 2 ").update_all("overtime_count = 0")
	User.where("overtime_count == 11").update_all("overtime_count = 10" )

	User.update_all("visible = 0, overtime_count = 0")
	
	Overtime.update_all("ot = 0")
  end


