#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-11-05

Challenge 189 Array Degree  ( Ruby )



You are given an array of 2 or more non-negative integers.

Write a script to find out the smallest slice, i.e. contiguous

subarray of the original array, having the degree of the given array.

The degree of an array is the maximum frequency of an element in the array.

=end



$arr = [[1,3,3,2], [1,2,1,3], [1,3,2,1,2], [1,1,2,3,2], [2,1,2,1,1]]

$degrees = {0 => 0, 1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 0,7 => 0,8 => 0,9 => 0}



def ArrayDegree ( a )         # get degree for each char in array

  a.each do |val|

    $degrees[val] += 1

  end

end



def main()

  $arr.each do |a|

    puts "Input: @array = #{a}"

    $degrees.each { |k, v| $degrees[k] = 0 }

    out = []

    ArrayDegree(a)

    max = $degrees.values.max                # get max degree of array

    $degrees.each do |k,v|

      if (v == max)

        s   =  a.index(k)

        e   =  a.rindex(k)

        str = a[s..e].join("")

        out.push(str)

      end

    end

    ans = out.min {|x,y| x.size <=> y.size}  # compare entries based on size,get smallest

    printf "Output: %s\n\n", ans.split("")

  end

end



main()



=begin

SAMPLE OUTPUT

Input: @array = [1, 3, 3, 2]

Output: ["3", "3"]



Input: @array = [1, 2, 1, 3]

Output: ["1", "2", "1"]



Input: @array = [1, 3, 2, 1, 2]

Output: ["2", "1", "2"]



Input: @array = [1, 1, 2, 3, 2]

Output: ["1", "1"]



Input: @array = [2, 1, 2, 1, 1]

Output: ["1", "2", "1", "1"]

=end
