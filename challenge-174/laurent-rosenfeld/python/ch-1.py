def is_disarium(num):
    n = num
    size = len(str(n))
    sum = 0
    while n > 0:
        sum += (n % 10) ** size
        n //= 10
        size -= 1
    return sum == num

i = 0
count = 0
while count < 19:
    if is_disarium(i):
        print(i)
        count += 1
    i += 1
