function is_abundant(n)
    sum = 0
    for i in 1:n/2
        if n % i == 0
            sum += i
            if sum > n
                return true
            end
        end
    end
    return false
end

j = 1
count = 0
while count < 20
    if is_abundant(j)
      print(j, " ")
      global count += 1
    end
    global j += 2
end
