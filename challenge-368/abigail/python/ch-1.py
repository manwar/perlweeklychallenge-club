#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    [input, digit] = line . rstrip () . split ()

    n = 0
    #
    # Find the first occurrence of the digit, followed by a digit
    # which is larger. If found, remove the digit. If the digit is 9,
    # don't bother, as no other digit is larger than 9.
    #
    if digit != "9":
        ndigit = str (int (digit) + 1)
        pat = digit + "(?=[" + ndigit + "-9])"
        [ninput, n] = re . subn (pat, "", input, count = 1)

    #
    # If the previous block did not find a match, remove the last
    # occurrence of the digit in the input string.
    #
    if n == 0:
        ninput = re . sub ("(.*)" + digit, "\\1", input, count = 1)

    print (ninput)
