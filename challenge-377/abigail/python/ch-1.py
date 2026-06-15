#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    if re . search (r"(.).?\1|(.)(.).*\3\2", line):
        print ("true")
    else:
        print ("false")
