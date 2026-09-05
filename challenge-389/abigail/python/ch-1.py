#!/opt/homebrew/bin/python3

import sys, re

for line in sys . stdin:
    parts = re . split (r'\s+', line)
    nr_of_notes = len (parts) // 2 - 1
    notes = [""] * nr_of_notes
    for i in range (1, nr_of_notes + 1):
        notes [int (parts [i + nr_of_notes]) - 1] = parts [i]
    print (parts [0] . upper () + " => " + " " . join (notes))
