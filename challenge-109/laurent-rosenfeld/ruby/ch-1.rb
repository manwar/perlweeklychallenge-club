def chowla (n)
    sum = 0
    for i in 2..n/2
        if n % i == 0
            sum += i
        end
    end
    return sum;
end

max = 37
results = []
for n in 1..max
    results[n-1] = chowla(n)
end
puts "The #{max} first Chowla numbers are:  #{results.join(" ")}"
