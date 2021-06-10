#!/usr/bin/env python

# run <script> <space-separated digits>

import re
import sys

print(attemptedOut if (int(attemptedOut := re.sub(r"(.)([13579]*)$", r"\2\1", "".join(sorted(sys.argv[1:], reverse=True)))) % 2 == 0) else "No even digits..")
