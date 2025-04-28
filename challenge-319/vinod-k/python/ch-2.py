array_1 = [1, 2, 3, 4]
array_2 = [3, 4, 5, 6]
result = []

for e1 in array_1:
    for e2 in array_2:
        if e1 == e2:
            result.append(e1)

if len(result) > 0:
    min_val = result[0]
else:
    min_val = -1

print(min(result))
