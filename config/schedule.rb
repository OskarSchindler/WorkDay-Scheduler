set :environment,"development"

every 5.minutes do
  rake "db:updatewh"
end

