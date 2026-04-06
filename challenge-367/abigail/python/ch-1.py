#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    count_0 = 0
    count_1 = 0
    for ch in line:
        if ch == "0":
            count_0 = count_0 + 1
        if ch == "1":
            count_1 = count_1 + 1
    for i in range (1, count_1):
        print ("1", end = "")
    for i in range (0, count_0):
        print ("0", end = "")
    print ("1")
