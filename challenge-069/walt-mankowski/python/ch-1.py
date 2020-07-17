from sys import argv

flip = [str(x) for x in [0, 1, 'x', 'x', 'x', 'x', 9, 'x', 8, 6]]

def is_strobogrammatic(n):
    flipped = n.translate(str.maketrans('0123456789', '01xxxx9x86'))[::-1]
    return n == flipped

A, B = [int(x) for x in argv[1:3]]
for n in range(A, B+1):
    if is_strobogrammatic(str(n)):
        print(n)
