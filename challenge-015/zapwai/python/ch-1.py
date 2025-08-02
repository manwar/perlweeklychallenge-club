primes = [2]
avg = []

def fill_primes(num):
    i = primes.pop()
    primes.append(i)
    while len(primes) < num:
        i += 1
        cnt = 0
        for p in primes:
            if i % p == 0:
                cnt +=  1
        if cnt == 0:
            primes.append(i)

def avg_primes():
    for i in range(1, len(primes) - 1):
        avg.append((primes[i + 1] + primes[i - 1]) / 2)

fill_primes(60)
avg_primes()

primes = primes[1:]
primes.pop()

weak = []
strong = []
other = []
for i in range(len(primes)):
    if primes[i] < avg[i]:
        weak.append(primes[i])
    elif primes[i] > avg[i]:
        strong.append(primes[i])
    else:
        other.append(primes[i])

print(weak[0:10])
print(strong[0:10])

