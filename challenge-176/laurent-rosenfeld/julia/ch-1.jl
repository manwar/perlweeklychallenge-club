function check_multiples(n)
    ordered = sort(digits(n))
    for j in 2:6
        if sort(digits(n * j)) != ordered
            return false
        end
    end
    return true
end

i = 1
while true
    if check_multiples(i)
        println(i)
        break
    end
    global i += 1
end
