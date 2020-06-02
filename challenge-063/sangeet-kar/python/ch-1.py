#!/usr/bin/env python

import re

def last_word(string, regex):
    return next((word for word in reversed(string.split()) if re.search(regex, word)), None)

assert last_word('  hello world', r"[ea]l") == 'hello'
assert last_word("Don't match too much, Chet!",  re.compile(r"ch.t", re.I)) == 'Chet!'
assert last_word("spaces in regexp won't match", r"in re") == None
assert last_word( ' '.join(str(x) for x in range(1, 1000000)), r"^(3.*?){3}") == '399933'
print("All tests passed")
