#!/usr/bin/env ruby
=begin comment
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-16
Challenge 239 Task 01 Same String ( Ruby )
------------------------------------
=end comment

myarr1 = [["ab", "c"],["ab", "c"],["ab", "cd", "e"]]
myarr2 = [["a", "bc"],["ac", "b"],["abcde"]]

cnt = 0

while cnt < myarr1.length()
    puts("Input:  @arr1 = [#{myarr1[cnt]}]")
    puts("\t@arr2 = [#{myarr2[cnt]}]")
    myarr1[cnt].join == myarr2[cnt].join ? puts("Output: true\n\n") : puts("Output: false\n\n")
    cnt += 1
end

=begin comment
-------------------------------------
SAMPLE OUTPUT

ruby .\SameString.rb

Input:  @arr1 = [["ab", "c"]]
        @arr2 = [["a", "bc"]]
Output: true

Input:  @arr1 = [["ab", "c"]]
        @arr2 = [["ac", "b"]]
Output: false

Input:  @arr1 = [["ab", "cd", "e"]]
        @arr2 = [["abcde"]]
Output: true
------------------------------------
=end comment



