#!/usr/bin/env ruby
=begin
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-31
Challenge 228 Task 1 Unique Sum ( Ruby )
-----------------------------------------
=end

myints = [[2, 1, 3, 2],[1, 1, 1, 1],[2, 1, 3, 4]]

$hash = Hash.new

def CreateHash(h)
    $hash.clear()
    ln = h.length()
    cnt = 0
    while cnt < ln
        hkey = h[cnt]
        $hash[hkey] = 0
        cnt += 1
    end
    cnt = 0
    while cnt < ln
        hkey = h[cnt]
        $hash[hkey] += 1
        cnt += 1
    end
end

def FindUniqueSum()
    flag = 0
    sum = 0;
    $hash.each do |key,value|
        sum += key if $hash[key] == 1
    end
    puts("Output: #{sum}\n\n");
end


myints.each do |h|
    puts("Input: @int = #{h}")
    CreateHash(h)
    FindUniqueSum()
end

=begin
-----------------------------------------
SAMPLE OUTPUT
ruby .\UniqueSum.rb

Input: @int = [2, 1, 3, 2]
Output: 4

Input: @int = [1, 1, 1, 1]
Output: 0

Input: @int = [2, 1, 3, 4]
Output: 10
-----------------------------------------
=end


