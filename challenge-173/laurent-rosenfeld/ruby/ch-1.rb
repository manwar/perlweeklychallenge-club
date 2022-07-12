def is_esthetic(m)
    n = m.to_s
    for i in 1..(n.length - 1)
        if (n[i].to_i - n[i-1].to_i).abs != 1
            return false
        end
    end
    return true
end

for test in [ 5456, 120, 121, 23456, 2346, 7654567, 765467]
    printf "%-9d ", test
    if is_esthetic(test)
        print("is esthetic\n")
    else
        print("is not esthetic\n")
    end
end
