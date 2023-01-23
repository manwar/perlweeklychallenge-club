#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE:   01-18-2023

Challenge #200 Arithmetic Slices ( Ruby )

=end

 

lists = [[1,2,3,4],[2]]

$out = Array.new

 

def GetIntervals(slice)

                if slice.length < 3 then

                                return(-1)

                end

                x = 0

                               

                while ( x < slice.length() )

                                if ( x > 0 )

                                                interval = slice[x] - slice[x-1]

                                                $out.push(interval)

                                end

                                x += 1

                end

                testval = $out[0]

                $out.each do |arrint|

                                if ( arrint != testval )

                                                return -1;

                                end

                end

                return 1;

end

 

lists.each do |list|

                cnt = 0

                puts("Input: @array = #{list}");

                slice = Array.new

                print("Output: ")

                while cnt < list.length()

                                slice = list[cnt, 3]

                                if slice.length == 3

                                                retval = GetIntervals(slice)

                                                if retval == 1

                                                                print("#{slice} ")

                                                end

                                end

                                cnt = cnt + 1

                                slice = Array.new()

                end

                ret = GetIntervals(list)

                ret == 1 ? (puts("#{list}");puts(" ")) : puts("()");

end

 

=begin

SAMPLE OUTPUT

ruby .\ArithmeticSlices.rb

Input: @array = [1, 2, 3, 4]

Output: [1, 2, 3] [2, 3, 4] [1, 2, 3, 4]

 

Input: @array = [2]

Output: ()

=end
