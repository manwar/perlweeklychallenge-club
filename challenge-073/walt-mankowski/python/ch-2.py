from sys import argv

a = [int(x) for x in argv[1:]]
output = [0]
curmin = a[0]

for x in a[1:]:
    output.append(curmin if curmin < x else 0)
    curmin = min(curmin, x)

print(output)
