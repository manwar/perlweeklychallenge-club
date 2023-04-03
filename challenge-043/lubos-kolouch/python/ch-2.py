def self_descriptive(base):
    def sd(n):
        digits = [int(d) for d in str(n)]
        counts = [0] * base
        for d in digits:
            counts[d] += 1
        return int("".join(map(str, counts))) == n

    n = base
    while True:
        if sd(n):
            yield n
        n += 1


gen = self_descriptive(10)
for _ in range(5):
    print(next(gen))
