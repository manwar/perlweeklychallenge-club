#!/usr/bin/env ruby
=begin
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-02
Challenge 237 Task 01 Seize the Day ( Ruby )
-----------------------------------------
=end
require 'date'
$year = ARGV[0].to_i
$day_of_week = ARGV[3].to_i
$month = ARGV[1].to_i

def main()
    cnt = 0
    weekday_of_month = sprintf("%02d", ARGV[2]).to_i
    days_in_month = (Date.new($year,$month, -1).day)
    puts("Input: Year = #{$year}, Month = #{$month}, Weekday of month = #{weekday_of_month}, day of week = #{$day_of_week}")
    d = 1
    fnd = 0
    while d <= days_in_month
        str = $year.to_s + "-"  + $month.to_s + "-" + d.to_s
        pd = Date.parse(str)
        if (pd.wday == $day_of_week)
            cnt += 1
            if (cnt == weekday_of_month)
                puts("Output: #{pd.mday}")
                fnd += 1
            end
        end
        d += 1
    end
    if (fnd == 0)
        puts("Output: 0")
    end
end

main()

=begin
------------------------------------------
SAMPLE OUTPUT
ruby .\SeizeDay.rb 2024 4 3 2

Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
Output: 16

ruby .\SeizeDay.rb 2025 10 2 4

Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
Output: 9

ruby .\SeizeDay.rb 2026 8 5 3

Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
Output: 0
-----------------------------------------
=end



