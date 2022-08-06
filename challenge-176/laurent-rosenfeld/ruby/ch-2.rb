def is_reversible(n)
    sum = n + n.to_s.reverse.to_i
    while (sum > 0)
        k = sum % 10
        if k % 2 == 0
          return false
        end
        sum /= 10
    end
    return true
end

for i in 1..100
    if is_reversible(i)
        printf("%d ", i)
    end
end
puts("")
