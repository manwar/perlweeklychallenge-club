#!/usr/bin/env ruby
=begin
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Count Words Task 2 ( Ruby )
----------------------------------
=end
wds = [["pay", "attention", "practice", "attend"],["janet", "julia", "java", "javascript"]]
prefix = ["at", "ja"]

cnt = 0;

wds.each do |w|
    seen = 0
    puts("Input:  @words = #{w}")
    p = prefix[cnt]
    puts("\t\$prefix = #{p}")
    w.each do |elem|
        if elem =~ /^#{p}/
            seen += 1
        end
    end
    puts("\tOutput: #{seen}\n\n")
    cnt += 1
end

=begin
----------------------------------
SAMPLE OUTPUT
ruby .\CountWords.rb

Input:  @words = ["pay", "attention", "practice", "attend"]
        $prefix = at
        Output: 2

Input:  @words = ["janet", "julia", "java", "javascript"]
        $prefix = ja
        Output: 3
----------------------------------
=end


