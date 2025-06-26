from sys import argv

min_dist = 1e300
pairs = []
elements = sorted(map(int, argv[1:]))

for i in range(0, len(elements) - 1):
    for j in range(i+1, len(elements)):
        delta = abs(elements[i] - elements[j])
        if delta < min_dist:
            pairs = [[elements[i], elements[j]]]
            min_dist = delta
        elif delta == min_dist:
            pairs.append([elements[i], elements[j]])

print(pairs)

