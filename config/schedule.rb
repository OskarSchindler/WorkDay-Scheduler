every 1.minute do
  runner "User.incr_workhour"
end
