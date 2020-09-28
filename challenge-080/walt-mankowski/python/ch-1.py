from sys import argv

n = { int(x) for x in argv[1:] }

i = 1
while (True):
    if i in n:
        i += 1
    else:
        print(i)
        break
