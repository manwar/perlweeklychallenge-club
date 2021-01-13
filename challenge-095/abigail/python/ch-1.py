import fileinput
import re

for line in fileinput . input ():
    #
    # Make sure the string is in UTF-8, and remove any newlines
    #
    line = line . decode ("utf-8") . strip ()

    #
    # Should look like an unsigned number (possible decimal)
    # and be a palindrome.
    #
    if (re . match (r'^\d+(\.\d+)?$', line, re . UNICODE) and
        line == line [::-1]):
        print 1
    else:
        print 0
