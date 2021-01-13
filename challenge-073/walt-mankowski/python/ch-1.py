from sys import argv

a = [int(x) for x in argv[1:]]
s = a.pop()
out = [min(a[i:i+s]) for i in range(len(a)-s)]
print(out)
