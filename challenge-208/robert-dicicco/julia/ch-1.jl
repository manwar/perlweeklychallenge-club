#!/usr/bin/env julia
#=
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-14
Challenge 208 Minimum Index Sum ( Julia )
------------------------------------------
=#
using Printf

list1 = [["Perl", "Raku", "Love"],["A","B","C"], ["A", "B", "C"]]
list2 = [["Raku", "Perl", "Hate"],["C","A","B"], ["D", "E", "F"]]

set1 = Set()
set2 = Set()

ln = length(list1)

for j in 1:ln
    println("Input: @list1 = ",list1[j])
    println("       @list2 = ",list2[j])
    global set1,set2
    set1 = list1[j]
    set2 = list2[j]
    println("Output: ",intersect(set1, set2))
    println("\n")
end

#=
------------------------------------------
SAMPLE OUTPUT
julia .\MinIndexSum.jl
Input: @list1 = ["Perl", "Raku", "Love"]
       @list2 = ["Raku", "Perl", "Hate"]
Output: ["Perl", "Raku"]


Input: @list1 = ["A", "B", "C"]
       @list2 = ["C", "A", "B"]
Output: ["A", "B", "C"]


Input: @list1 = ["A", "B", "C"]
       @list2 = ["D", "E", "F"]
Output: String[]

------------------------------------------
=#


