require 'date'

year = ARGV.shift.to_i.nil? || 2022

for month in 1..12
    lmd = Date.new(year, month, 1).next_month.prev_day
    weekday = lmd.wday
    puts lmd - (weekday % 7)
end
