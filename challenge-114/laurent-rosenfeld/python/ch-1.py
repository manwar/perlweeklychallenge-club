import sys

num = int(sys.argv[1])
while (1):
    if str(num) == str(num)[::-1]:
        print(num)
        break
    num += 1
