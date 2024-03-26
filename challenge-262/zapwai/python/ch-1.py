ints = [-3, 1, 2, -1, 3, -2, 4]
print("Input:", ints)
neg = 0
pos = 0
for num in ints:
    if num < 0:
        if neg > num:
            neg = num
    else:
        if pos < num:
            pos = num
ans = max(abs(neg), pos)
print("Output:", ans)
