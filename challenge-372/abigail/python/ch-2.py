#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    chars = list (line . strip ())  # Array of characters, sans newline
    max   = -1                      # Track maximum distance

    for f in range (0, len (chars)):             # For each character,
        for l in range (len (chars) - 1, f, -1): # find matching character
            if  chars [f] == chars [l]:          # from the end
                if l - f - 1 > max:              # If larger distance,
                    max = l - f - 1              # remember it
                break

    print (max)
