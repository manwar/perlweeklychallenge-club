fact = 1
left_fact = 1
for n = 1, 10 do
    print(left_fact)
    fact = fact * n
    left_fact = left_fact + fact
end
