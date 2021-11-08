import sys
def isUgly(n):
    for div in [2, 3, 5]:
        while (n % div == 0):
            n = n / div;
    if n == 1:
        return True
    return False;

count = 0
i = 0
target = int(sys.argv[1])
while count <= target:
    i += 1;
    if isUgly(i):
        count += 1;
    if count == target:
        print(i)
        break
