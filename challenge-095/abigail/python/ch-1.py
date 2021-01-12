import fileinput
import re

for line in fileinput . input ():
    line = line . rstrip ()
    if (re . match (r'^\d+(\.\d+)?$', line) and line == line [::-1]):
        print 1
    else:
        print 0
