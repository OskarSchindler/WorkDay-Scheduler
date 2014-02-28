namespace :db do
  desc "Update Workhours"
  task updatewh: :environment do
    incr_workhour
  end
end


  def incr_workhour
	User.update_all("workhour = workhour + 8" , " leave == 0 " )
	User.update_all("leave = 0")
  end
