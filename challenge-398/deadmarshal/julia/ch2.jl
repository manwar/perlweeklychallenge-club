#!/usr/bin/env julia

function string_difference(words)
  ks = String[]
  h = Dict{String,Int}()
  for w in words
    ord = [Int(c) - Int('a') for c in w]
    key = join((ord[i+1] - ord[i] for i in 1:length(ord)-1),",")
    push!(ks,key)
    h[key] = get(h,key,0) + 1
  end
  for (i,w) in enumerate(words)
    h[ks[i]] == 1 && return w
  end
  return -1
end

println(string_difference(["ab","bc","cd","zy"]))
println(string_difference(["cba","fed","azy"]))
println(string_difference(["pop","ada","beb","cfc"]))
println(string_difference(["aaaa","zzzz","mmmm","aaba"]))
println(string_difference(["aceg","bdfh","cegi","azbz"]))

