#!/usr/bin/env julia
#=
------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-21
Challenge 240 Task 01 Acronym ( Julia )
------------------------------------
=#

using Printf

mystr = [["Perl", "Python", "Pascal"],["Perl", "Raku"],["Oracle", "Awk", "C"]]
mychk = ["ppp","rp","oac"]

cnt = 1

function GetFirstLetters(wds)
    acronym = ""
    for w in wds
        acronym = string(acronym, lowercase(w[1,1]))
     end
    return acronym
end

for str in mystr
    global cnt
    @printf("Input: @str = %s\n",str)
    @printf("check = %s\n", mychk[cnt])
    retval == mychk[cnt] ? println("Output: true\n\n") : println("Output: false\n\n")
    cnt += 1
end

#=
------------------------------------
SAMPLE OUTPUT

ruby .\Acronym.rb

Input: @str = ["Perl", "Python", "Pascal"]
check = ppp
Output: true

Input: @str = ["Perl", "Raku"]
check = rp
Output: false

Input: @str = ["Oracle", "Awk", "C"]
check = oac
Output: true
------------------------------------
=#


