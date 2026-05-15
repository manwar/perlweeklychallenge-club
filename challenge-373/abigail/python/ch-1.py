#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    line  = line . strip ("\n")                           # Remove newline
    line  = re . sub (r" ",  "", line)                    # Remove spaces
    line  = re . sub (r"\.", "", line)                    # Remove dots
    parts = re . split (r";", line)                       # Split on ;
    print ("true" if parts [0] == parts [1] else "false") # Equal?
