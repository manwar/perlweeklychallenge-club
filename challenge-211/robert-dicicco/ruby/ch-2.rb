#!/usr/bin/env ruby
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-04
Challenge 211 Split Same Average ( Ruby)
----------------------------------------
=end

nums = [1,2,3,4,5,6,7,8];

flag = 0;

puts("Input: @nums = #{nums}")
puts('')
$check = false

(1..4).each do |x|                      # check arrays from 1 to 4 in length
    puts("x = #{x}:")
    pn = nums.combination(x).to_a       # create an array containing x elements
    flag = 0
    pn.each do |p|
        sec_arr = []
        nums.each do |v|
            $check = p.include? v
            if $check == false
                sec_arr.push(v)
            end
        end
        first_avg = p.sum / 4.to_f
        sec_avg   = sec_arr.sum / 4.to_f
        if (first_avg == sec_avg and first_avg > 0 and sec_avg > 0)
            puts("-----> #{p}  #{sec_arr}  #{first_avg} : #{sec_avg}")
            flag = 1
        end
    end
    flag == 1 and $check == true ? puts("{Output: true") : puts("Output: false")
end

=begin
----------------------------------------
SAMPLE OUTPUT
ruby .\SplitSame.rb
Input: @nums = [1, 2, 3, 4, 5, 6, 7, 8]

x = 1:
x = 2:
x = 3:
-----> [3, 7, 8]  [1, 2, 4, 5, 6]  4.5 : 4.5
-----> [4, 6, 8]  [1, 2, 3, 5, 7]  4.5 : 4.5
-----> [5, 6, 7]  [1, 2, 3, 4, 8]  4.5 : 4.5
{Output: true
x = 4:
-----> [1, 2, 7, 8]  [3, 4, 5, 6]  4.5 : 4.5
-----> [1, 3, 6, 8]  [2, 4, 5, 7]  4.5 : 4.5
-----> [1, 4, 5, 8]  [2, 3, 6, 7]  4.5 : 4.5
-----> [1, 4, 6, 7]  [2, 3, 5, 8]  4.5 : 4.5
-----> [2, 3, 5, 8]  [1, 4, 6, 7]  4.5 : 4.5
-----> [2, 3, 6, 7]  [1, 4, 5, 8]  4.5 : 4.5
-----> [2, 4, 5, 7]  [1, 3, 6, 8]  4.5 : 4.5
-----> [3, 4, 5, 6]  [1, 2, 7, 8]  4.5 : 4.5
{Output: true
----------------------------------------
=end

