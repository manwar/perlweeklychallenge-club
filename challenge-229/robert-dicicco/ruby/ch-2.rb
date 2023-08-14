#!/usr/bin/env ruby
=begin
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-09
Challenge 229 Two Out Of Three  Task 2 ( Ruby )
------------------------------------------------
=end
#arrays = [[1, 1, 2, 4,],[2, 4],[4]]
arrays = [[4, 1],[2, 4],[1, 2]]

$hash = Hash.new
cnt = 1

def CreateCounts(a)
    for i in a
        if $hash.has_key?(i)
            $hash[i] += 1
        else
            $hash[i] = 1
        end
    end
end

arrays.each do |a|
    a = a.uniq
    if cnt == 1
        array1 = a
        CreateCounts(array1)
        puts("Input:  \@array1 = #{array1}")
    elsif cnt == 2
        array2 = a
        CreateCounts(array2)
        puts("\t\@array2 = #{array2}")
    elsif cnt == 3
        array3 = a
        CreateCounts(array3)
        puts("\t\@array3 = #{array3}")
    else
        puts("ERROR!")
        exit
    end
    cnt += 1
end

print("Output: ( ")
$hash.each do |ky, val|
    if val >= 2
        print("#{ky} ")
    end
end
print(" \)\n\n")

=begin
------------------------------------------------
SAMPLE OUTPUT
ruby .\TwoThree.rb
Input:  @array1 = [1, 2, 4]
        @array2 = [2, 4]
        @array3 = [4]
Output: ( 2 4  )

ruby .\TwoThree.rb
Input:  @array1 = [4, 1]
        @array2 = [2, 4]
        @array3 = [1, 2]
Output: ( 4 1 2  )
------------------------------------------------
=end


