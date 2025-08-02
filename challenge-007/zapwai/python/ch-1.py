def niven(n):
    for i in range(1, n+1):
        tally = 0
        digit = list(str(i))
        for j in range(len(digit)):
            tally += int(digit[j])
        if i % tally == 0:
            print(i)
niven(51)
