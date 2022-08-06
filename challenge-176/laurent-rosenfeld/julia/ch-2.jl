for i in 1:100
    sum = i + parse(Int32, reverse(string(i)))
    if ! occursin(r"[02468]", string(sum))
        print("$i ")
    end
end
println(" ")
