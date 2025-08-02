x = "003407"
num = []
on = 0
for c in list(x):
    if c == "0":
        if on:
            num.append(c)
        else:
            continue
    else:
        on = 1
        num.append(c)
print("Input:", x)
print("Output:",''.join(num))
