def is_disarium(num)
    n = num.to_s
    sum = 0
    for i in 1..(n.length)
        sum += n[i-1].to_i**i
    end
    return sum == num
end

i = 0
count = 0
while count < 19
    if is_disarium(i)
        printf("%d ", i)
        count += 1
    end
    i += 1
end
print("\n")
