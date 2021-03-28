#!/usr/bin/env python3
#
#
#       name-game.py
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


import re
import sys

def makeSong( name ):    
    m = re.search("([^aeiouy]?)(.*)", name, re.I)
    (h, t) = m.group(1,2)
    
    print(f'''
    {name}, {name}, bo-{"b" if h != "B" else ""}{t}
    Bonana-fanna fo-{"f" if h != "F" else ""}{t}
    Fee fi mo-{"m" if h != "M" else ""}{t}
    {name}!
    ''')

for name in sys.argv[1:]:
    makeSong(name)





