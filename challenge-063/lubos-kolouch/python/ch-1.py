#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
from typing import Optional, Pattern


def last_word(string: str, regexp: Pattern) -> Optional[str]:
    """
    Returns the last word matching the given regular expression in the input string.
    
    Args:
        string (str): The input string to search for matching words.
        regexp (Pattern): The regular expression pattern to match words.

    Returns:
        Optional[str]: The last word matching the regular expression, or None if not found.
    """
    words = re.findall(r'\S+', string)
    last_word = None

    for word in words:
        if regexp.search(word):
            last_word = word

    return last_word


print(last_word('  hello world', re.compile(r'[ea]l')) or "None")  # 'hello'
print(
    last_word("Don't match too much, Chet!", re.compile(
        r'ch.t', re.IGNORECASE)) or "None")  # 'Chet!'
print(
    last_word("spaces in regexp won't match", re.compile(r'in re'))
    or "None")  #  None
print(
    last_word(' '.join(str(i) for i in range(1,
                                             int(1e6) + 1)),
              re.compile(r'^(3.*?){3}')) or "None")  # '399933'
