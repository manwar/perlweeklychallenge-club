#!python3

l = [1,1]

for i in range(2,20):
    l.append(l[i-2]+l[i-1]+1)

print(l)
