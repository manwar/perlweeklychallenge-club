def is_abundant(n)
    sum = 0
    for i in 1.upto(n/2)
        if n % i == 0 then
            sum += i
            if sum > n then
                return true
            end
        end
    end
    return false
end

j = 1
count = 0
while count < 20
    if is_abundant(j) then
        print("#{j} ")
        count += 1
    end
    j += 2
end
