s = BigInt(2)
println(s)
for i in 1:9
    s = s * (s - 1) + 1
    println(s)
end
