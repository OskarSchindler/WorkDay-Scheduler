set :environment,"production"

every :day,:at => "2:00pm" do
  rake "db:updatewh"
end

