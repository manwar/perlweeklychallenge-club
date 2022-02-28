fact = [1] * 10
for n in range (1, 10):
    fact[n] = n * fact[n - 1]

def is_factorion (input):
    sum = 0
    n = str(input)
    for i in range (0, len(n)):
        sum = sum + fact[int(n[i])]

    return input == sum

for n in range(1, 50000):
    if is_factorion(n):
        print(n)
