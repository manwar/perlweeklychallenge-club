function is_disarium(n)
    s = sum(i ^ p for (p, i) in enumerate(reverse(digits(n))))
    return s == n
end

count = 0
i = 0
while count < 19
    if is_disarium(i)
        println(i)
        global count += 1
    end
    global i += 1
end
