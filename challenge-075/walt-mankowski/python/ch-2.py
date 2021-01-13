from sys import argv
import numpy as np

def print_hist(hist, a, rows, cols):
    for row in range(rows-1, -1, -1):
        print(row+1, end='')
        for col in range(cols):
            print(f" {'#' if hist[row][col] else ' '}", end='')
        print()

    print('-', end='')
    print(" -" * cols)

    print(' ', end='')
    for i in range(cols):
        print(f' {a[i]}', end='')
    print()
    print()

a = [int(x) for x in argv[1:]]

# build the histogram
rows = max(a)
cols = len(a)
hist = np.zeros([rows, cols], dtype=bool)
for row in range(rows):
    for col in range(cols):
        if row < a[col]:
            hist[row][col] = True
print_hist(hist, a, rows, cols)

best_area = 0
best_height = -1
best_width = -1

for height in range(1, rows+1):
    for width in range(1, cols+1):
        area = height * width
        if area <= best_area:
            continue
        for r0 in range(row-height+1):
            for c0 in range(0, cols-width+1):
                if sum(sum(hist[r0:r0+height,c0:c0+width])) == area:
                    best_area = area
                    best_height = height
                    best_width = width

print(f'The best rectangle is {best_height} x {best_width} for an area of {best_area}')

