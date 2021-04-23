def chowla(n):
    sum = 0
    for i in range(2, int(n/2) +1):
        if n % i == 0:
            sum += i
    return sum

chowla_nums = []
for m in range (1, 21):
    chowla_nums.append (chowla(m))
print(chowla_nums)
