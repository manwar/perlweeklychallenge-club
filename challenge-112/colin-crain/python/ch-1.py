#!/usr/bin/env python3
#
#
#       where-are-my-friends.py
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

import os
import sys

if len(sys.argv) > 1:
    path = sys.argv[1]
else:
    path = '../../a/b/c///f/../d';

canonical = os.path.realpath(path)
  
print(canonical )
