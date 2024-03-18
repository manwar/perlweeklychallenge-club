def has_distinct_digits(num):
    h = []
    h.append( num % 10 )
    num_length = len(str(num))
    while num > 0:
        num = num // 10
        h.append( num % 10 )
    h.pop()
    uniq = set(h)
    return len(uniq) == num_length;

def proc():
    for i in range(150):
        if len(str(i*i)) >= 5 and has_distinct_digits(i*i):
            print(i,"has the square:",i*i)
            break;

proc()
