import re

tests = ("foo 0044 1148820341 42", "xyz +44 1148820342 abc", "44-11-4882-0343", " (44) 1148820344  ", "00 1148820345")

for str in tests:
    match = re.search("(\d{4}|\+\d\d|\(\d\d\))\s+\d{10}", str)
    if (match):
        print (match.group())
