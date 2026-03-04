#!/usr/bin/env python3

import re
import sys

if re.search(r'  ^ [-+]?                '+
             r'    (?: \d+ \. \d* |     '+
             r'        \d* \. \d+ |     '+
             r'        \d+              '+
             r'    )                    '+
             r'    (?: e [-+]? \d+ )?   '+
             r'  $', sys.argv[1], re.X+re.I):
    print('true')
else:
    print('false')
