set :environment,"production"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 8.hours do
  rake "db:updatewh"
end

