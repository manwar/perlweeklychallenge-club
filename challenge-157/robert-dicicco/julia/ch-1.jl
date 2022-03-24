#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 24-MAR-2022
# Challenge 157 Pythagorean Means ( Julia )

using StatsBase

A = (1,3,5,6,9)

AM = round(mean(A), digits = 1)
GM = round(geomean(A), digits=1)
HM = round(harmmean(A), digits=1)

println("Input: ",A)

println("AM = $AM  GM = $GM  HM = $HM\n")

A = (2,4,6,8,10)

AM = round(mean(A), digits = 1)
GM = round(geomean(A), digits=1)
HM = round(harmmean(A), digits=1)

println("Input: ",A)

println("AM = $AM  GM = $GM  HM = $HM\n")

A = (1,2,3,4,5)

AM = round(mean(A), digits = 1)
GM = round(geomean(A), digits=1)
HM = round(harmmean(A), digits=1)

println("Input: ",A)

println("AM = $AM  GM = $GM  HM = $HM\n")
