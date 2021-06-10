tests = [2, 9, 3, 5]
sorted = sorted(tests)
max = 0 if len(sorted) <= 1 else (
    max(map(lambda i: sorted[i] - sorted[i-1],
    range(1, len(sorted) ))))
print("Max gap = ", max)
