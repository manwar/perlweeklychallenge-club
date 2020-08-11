#!/usr/bin/env python3

# Problem: Write a script to display first 20 Leonardo Numbers.

leonardo = [1,1]
for i in range(2,21):
    leonardo.append(leonardo[i-2] + leonardo[i-1] + 1)

print(leonardo)
