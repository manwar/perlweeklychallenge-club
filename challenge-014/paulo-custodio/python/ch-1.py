#!/usr/bin/python3

# Challenge 014
#
# Challenge #1
# Write a script to generate Van Eck's sequence starts with 0. For more
# information, please check out wikipedia page. This challenge was proposed by
# team member Andrezgz.

def van_eck_iter():
    hist = []
    # first two terms
    hist.append(0)
    yield hist[-1]

    hist.append(0)
    yield hist[-1]

    while True:
        found = False
        for m in range(len(hist)-2, -1, -1):
            if hist[m]==hist[-1]:
                hist.append(len(hist)-1-m)
                yield hist[-1]
                found = True
                break
        if not found:
            hist.append(0)
            yield hist[-1]

sep = ""
output = ""
count = 0
for n in van_eck_iter():
    output += sep + str(n)
    sep = ", "
    count += 1
    if count >= 96:
        break
print(output)
