#!julia.exe

# Author: Robert DiCicco
# DATE: 2022-07-05
# Challenge 172 Five Numbers ( Julia )

using Statistics
using Printf

myarray = [10,11,12,18,13,14,15]

myarray = sort(myarray)

q1 = quantile(myarray,[0.25])

q3 = quantile(myarray,[0.75])

println(myarray)

@printf("Min = %0.2f  Q1 = %0.2f   Median = %0.2f  Q3 = %0.2f  Max = %0.2f\n", minimum(myarray), q1[1], median(myarray), q3[1], maximum(myarray))
