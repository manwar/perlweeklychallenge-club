from sys import argv

n = [int(x) for x in argv[1:]]
candy = len(n)

# right neighbors
for i in range(len(n)-1):
    if n[i] > n[i+1]:
        candy += 1

# left neighbors
for i in range(1, len(n)):
    if n[i] > n[i-1]:
        candy += 1

print(candy)
