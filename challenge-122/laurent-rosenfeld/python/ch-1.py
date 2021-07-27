n = list(range(10, 100, 10)) # [10, 20 ... 90]
mvg = [n[0]]
for i in range(1, 9):
    mvg.append((mvg[i-1] * i + n[i])  / (i + 1))
print(mvg)
