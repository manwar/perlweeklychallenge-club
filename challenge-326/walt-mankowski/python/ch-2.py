from sys import argv

output = []

for i in range(1, len(argv), 2):
    cnt = int(argv[i])
    val = int(argv[i+1])
    output += [val] * cnt

print(output)
