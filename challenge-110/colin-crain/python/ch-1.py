#!/usr/bin/env python3
#
#
#       phone-block.py
#
#       Valid Phone Numbers
#         Submitted by: Mohammad S Anwar
#         You are given a text file.
# 
#         Write a script to display all valid phone numbers in the given text file.
# 
#         Acceptable Phone Number Formats
#             +nn  nnnnnnnnnn
#             (nn) nnnnnnnnnn
#             nnnn nnnnnnnnnn
# 
#         Input File
#             0044 1148820341
#              +44 1148820341
#               44-11-4882-0341
#             (44) 1148820341
#               00 1148820341
# 
#         Output
#             0044 1148820341
#              +44 1148820341
#             (44) 1148820341
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

import re

f = open("phone-numbers.txt", "r")
for line in f:
    pn = re.search(r"((?:\d{4}|\(\d\d\)|\+\d\d)\s\d{10}(?!\d))", line)
    if pn != None:
        print('{0:>16s}'.format(pn.group()))

f.close
