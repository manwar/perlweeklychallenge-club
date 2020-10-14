from sys import argv

def is_interleave(a, b, c):
    if a == '' and b == '' and c == '':
        return 1
    elif c == '':
        return 0

    found = False
    if len(a) > 0 and a[0] == c[0]:
        found = True
        return is_interleave(a[1:], b, c[1:])

    if len(b) > 0 and b[0] == c[0]:
        found = True
        return is_interleave(a, b[1:], c[1:])

    if not found:
        return 0

a, b, c = argv[1:]

print(is_interleave(a, b, c))
