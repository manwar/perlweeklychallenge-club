from sys import argv

fname, a, b = argv[1:5]
a = int(a)
b = int(b)

with open(fname) as f:
    lineno = 1
    for line in f:
        if a <= lineno <= b:
            print(line, end='')
        lineno += 1
        if lineno > b:
            break
