#!/usr/bin/env python3

import sys
import random
import re

if len(sys.argv) > 1:
    random.seed(int(sys.argv[1]))

for line in sys.stdin:
    def shuffle_inner(match):
        return match.group(1) + ''.join(random.sample(match.group(2), len(match.group(2)))) + match.group(3)

    line = re.sub(r'(\w)(\w*)(\w)', shuffle_inner, line)
    print(line, end='')
