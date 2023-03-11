#!/usr/bin/env ruby
=begin
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-06
Challenge 207 Keyboard Word ( Ruby )
--------------------------------------
=end

$rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
words = [["Hello Alaska Dad Peace"], ["OMG Bye"]]
$flag = 0

def CheckLetters(w)
    w = w.downcase   # convert to lc
    ln = w.length
    (0..2).each do |str|
        $flag = 0
        (0..ln-1).each do |x|
            unless $rows[str].include? w[x]
                $flag += 1
             end
        end
        if ($flag == 0)
            puts("\t#{w}")
        end
    end
 end

def GetWords(tws)
    tws.each do |tw|
        tw.delete! '[]\"'
        #puts("#{tw}")
        CheckLetters(tw)
    end
    puts(" ")
end

words.each do |wds|
    puts("Input: @words = #{wds}")
    puts("Output: ")
    test_words = wds.to_s.split
    GetWords(test_words)
end
=begin
------------------------------------------
SAMPLE OUTPUT
ruby .\KeyboardWord.rb
Input: @words = ["Hello Alaska Dad Peace"]
Output:
        alaska
        dad

Input: @words = ["OMG Bye"]
Output:
-------------------------------------------
=end


