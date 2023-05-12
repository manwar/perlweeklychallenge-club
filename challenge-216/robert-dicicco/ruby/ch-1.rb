#!/usr/bin/env ruby
=begin
--------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-08
Challenge 216 Registration Number ( Ruby )
--------------------------------------------
=end

@words = [['abc', 'abcd', 'bcd', 'AB1 2CD'], ['job', 'james', 'bjorg', '007 JB'], ['crack', 'road', 'rac', 'C7 RA2']]

$out = []
def CheckWords(wd, rg)
    arr = rg.split(//)
    flag = 0
    arr.each do |lett|
         if ! wd.include? lett
             flag = 1;         # set flag to 1 if no match
        end
    end
    if flag == 0
        $out.push(wd)
    end
end

@words.each do |wds|
    $out = []
    len = wds.length()
    wds_only = wds.slice(0,len-1)
    reg = wds.slice(-1,1)
    reg = reg.to_s
    reg.delete! '[]"0123456789 '
    reg = reg.to_s.tr('A-Z', 'a-z')
    puts("Input: @words = #{wds_only}  $reg = #{reg}")
    x = 0
    cnt = len - 2
    while x <= cnt
         CheckWords(wds_only[x], reg)
        x += 1
    end
    puts("Output: #{$out}")
    puts('')
end

=begin
--------------------------------------------
SAMPLE OUTPUT
ruby .\Registration.rb
Input: @words = ["abc", "abcd", "bcd"]  $reg = abcd
Output: ["abcd"]

Input: @words = ["job", "james", "bjorg"]  $reg = jb
Output: ["job", "bjorg"]

Input: @words = ["crack", "road", "rac"]  $reg = cra
Output: ["crack", "rac"]
--------------------------------------------
=end


