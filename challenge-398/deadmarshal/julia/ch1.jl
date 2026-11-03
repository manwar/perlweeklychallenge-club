#!/usr/bin/env julia

function divisible_average(arr)
  f = filter(x -> x % 2 == 0 && x % 3 == 0,arr)
  isempty(f) && return 0
  return div(sum(f),length(f))
end

println(divisible_average([18,5,7,11]))
println(divisible_average([6,12,18,24,30,40]))
println(divisible_average([3,9,15,21,27]))
println(divisible_average([6,12,14,20]))
println(divisible_average([6,6,6,12,12]))

