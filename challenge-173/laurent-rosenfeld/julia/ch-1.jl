function is_esthetic(num)
    n = string(num)
    for i in 2:length(n)
        if abs(n[i] - n[i-1]) != 1
            return false
        end
    end
    return true
end

for test in [5456, 120, 121, 23456, 2346, 7654567, 765467]
    println("$test\t", is_esthetic(test) ? "Esthetic" : "Non esthetic")
end
