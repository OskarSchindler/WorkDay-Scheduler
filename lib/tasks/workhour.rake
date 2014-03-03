namespace :db do
  desc "Update Workhours"
  task updatewh: :environment do
    incr_workhour
  end
end


  def incr_workhour
	User.update_all("workhour = workhour + 8" , " leave != 10" )
	User.update_all("leave = 0","leave == 10")
	User.update_all("leave = 0","leave == 2")
	User.update_all("leave =10","leave == 11")
	User.update_all("idwh = idwh + 8")
	
	Overtime.update_all("ot = 0")
	User.update_all("workhour = workhour + 2" , "overtime_count == 10" )
	User.update_all("overtime_count = 0","overtime_count == 10")
	User.update_all("overtime_count = 0","overtime_count == 2")
	User.update_all("overtime_count = 10","overtime_count == 11")
  end


