from sys import argv

def S(n):
    s = ''
    for i in range(1, n+1):
        s += '0' + switch(rev(s))

    return s

def switch(s):
    return s.translate(str.maketrans('01', '10'))

def rev(s):
    return s[::-1]

n = int(argv[1])
print(S(n))
