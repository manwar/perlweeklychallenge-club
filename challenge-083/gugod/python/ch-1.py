#!/usr/bin/env python3
import sys

def wordsLength(s):
    s = s.strip(' ')
    p = s.find(' ')
    return 0 if p == -1 else (s.rfind(' ') - p - s.count(' ') + 1);

# print(wordsLength("hello namaste konnichiwa hello")); # 17
# print(wordsLength("hello namaste")); # 0
# print(wordsLength("hello"));    # 0

print("# " + sys.argv[1]);
print(wordsLength(sys.argv[1]));
