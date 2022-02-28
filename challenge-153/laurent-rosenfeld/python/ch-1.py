fact = 1
left_fact = 1

for n in range (1, 11):
    print(left_fact)
    fact = fact * n
    left_fact = left_fact + fact
