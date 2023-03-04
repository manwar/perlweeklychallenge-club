#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02=28
Challenge 206 Shortest Times ( Ruby )
---------------------------------------
=end

times = [["00:00", "23:55", "20:00"],["01:01", "00:50", "00:57"],["10:10", "09:30", "09:00", "09:55"]]

minutes = []
absval = 0

times.each do |tm|
    tms = tm.to_s
    shortest = 1441
    minutes.clear()
    absval = 0
    puts("Input: @array = #{tms}")
    ln = tm.length()

    (0..ln-1).each do |n|
        times_split = tm[n].to_s.split(':')
        hrs = times_split[0].to_i
        mins = times_split[1].to_i
        time_in_mins = (hrs * 60) + mins
        if time_in_mins == 0
            time_in_mins = 1440
        end
        minutes.push(time_in_mins)
    end

    ax = minutes.combination(2).to_a
    ax.each do |res|
        absval = (res[0] - res[1]).abs
        (absval < shortest) ? shortest = absval : shortest = shortest
    end

    puts("Output: #{shortest}")
    puts
end

=begin
-----------------------------------------------------
SAMPLE OUTPUT
ruby .\ShortestTime.rb
Input: @array = ["00:00", "23:55", "20:00"]
Output: 5

Input: @array = ["01:01", "00:50", "00:57"]
Output: 4

Input: @array = ["10:10", "09:30", "09:00", "09:55"]
Output: 15
-----------------------------------------------------
=end
