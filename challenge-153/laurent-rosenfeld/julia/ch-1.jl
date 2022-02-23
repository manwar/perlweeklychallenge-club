a = [1, 2] # Julia arrays start with index 1

for n in 3:10
    push!(a, n * a[n - 1] - (n - 1) * a[n - 2])
end
println(a)
