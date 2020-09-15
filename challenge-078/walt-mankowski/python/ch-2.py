from sys import argv

def rotate_by(b, a):
    return a[b:] + a[0:b]

a = [int(x) for x in argv[1].split(' ')]
b = [int(x) for x in argv[2].split(' ')]

for x in b:
    print(rotate_by(x, a))
