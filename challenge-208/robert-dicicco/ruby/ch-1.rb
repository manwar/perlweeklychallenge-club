#!/usr/bin/env ruby
=begin
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-14
Challenge 208 Minimum Index Sum ( Ruby )
------------------------------------------
=end

require 'set'

list1 = [["Perl", "Raku", "Love"],["A","B","C"], ["A", "B", "C"]]
$list2 = [["Raku", "Perl", "Hate"],["C","A","B"], ["D", "E", "F"]]

ln = list1.length()
$wds = Set

def create_new_set(i)
    $wds = Set.new()
    $list2[i].each do |z|
        $wds << z
    end
end

(0..ln-1).each do |i|
    create_new_set(i)
    printf("Input: @list1 = %s\n",list1[i])
    printf("       @list2 = %s\n",$list2[i])
    print("Output: ")
    (0..2).each do |x|
        if $wds.include?(list1[i][x])
            print("#{list1[i][x]} ")
        end
    end
    print("\n\n")
 end

=begin
 ------------------------------------------
 SAMPLE OUTPUT
 ruby .\MinIndexSum.rb
Input: @list1 = ["Perl", "Raku", "Love"]
       @list2 = ["Raku", "Perl", "Hate"]
Output: Perl Raku

Input: @list1 = ["A", "B", "C"]
       @list2 = ["C", "A", "B"]
Output: A B C

Input: @list1 = ["A", "B", "C"]
       @list2 = ["D", "E", "F"]
Output:

 ------------------------------------------
=end
