#!/usr/bin/perl
# The Weekly Challenge 165
# Task 2 Line of Best Fit
# Julia Solution
# ref:
# https://jahoo.github.io/2021/01/11/simplest_linear_regression_example.html


using Plots

data = [
333,129 ,
39,189 ,
140,156 ,
292,134 ,
393,52 ,
160,166 ,
362,122 ,
13,193 ,
341,104 ,
320,113 ,
109,177 ,
203,152 ,
343,100 ,
225,110 ,
23,186 ,
282,102 ,
284,98 ,
205,133 ,
297,114 ,
292,126 ,
339,112 ,
327,79 ,
253,136 ,
61,169 ,
128,176 ,
346,72 ,
316,103 ,
124,162 ,
65,181 ,
159,137 ,
212,116 ,
337,86 ,
215,136 ,
153,137 ,
390,104 ,
100,180 ,
76,188 ,
77,181 ,
69,195 ,
92,186 ,
275,96 ,
250,147 ,
34,174 ,
213,134 ,
186,129 ,
189,154 ,
361,82 ,
363,89 ,
]

xs = []
ys = []

for i = 1:2:length(data)-1
    push!(xs,data[i])
end

for i = 2:2:length(data)
    push!(ys,data[i])
end

scatter(xs, ys)

A = convert(Matrix{Float64}, hcat(xs, ones(length(xs))))

slope, intercept = inv(transpose(A)*A)*transpose(A) * ys

plot!(
    x -> slope*x + intercept, 
    legend = :none,
#    ratio = 1,  #optional
)

savefig("new_julia.svg")
