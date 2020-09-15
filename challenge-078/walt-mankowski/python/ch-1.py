from sys import argv

a = [int(x) for x in argv[1:]]
best = None
out = []

for i in range(len(a)-1, -1, -1):
    if best is None or a[i] > best:
        out.insert(0, a[i])
        best = a[i]

print(out)
