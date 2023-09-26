#!/usr/bin/env ruby
=begin
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-25
Challenge 236 Task 01 Exact Change ( Ruby )
-------------------------------------
=end

bills = [[5, 5, 5, 10, 20], [5, 5, 10, 10, 20],[5, 5, 5, 20]]

bills.each do |paid|
    puts("Input: @bills = #{paid}")
    cnt = 0
    change = 0
    while cnt < paid.length()
        ticket = paid[cnt]
        change_required = ticket - 5
        cnt += 1
        case ticket
        when 5
            change += 5
        when 10
            # pass
        when 20
            if change_required > change
                puts("Output: false\n\n")
                break
            else
                puts("Output: true\n\n")
                break
            end
            change -= 10
        end
    end
    cnt += 1
end

=begin
--------------------------------------
SAMPLE OUTPUT
ruby .\ExactChange.rb

Input: @bills = [5, 5, 5, 10, 20]
Output: true

Input: @bills = [5, 5, 10, 10, 20]
Output: false

Input: @bills = [5, 5, 5, 20]
Output: true
-------------------------------------
=end




