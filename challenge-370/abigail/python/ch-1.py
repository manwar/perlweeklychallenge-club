#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    #
    # Lower case input and split into the paragraph and banned parts
    #
    [paragraph, banned_str] = line . lower () . split ("//")

    #
    # Turn the banned part into a dictionary, indexing on banned words
    #
    banned = {}
    for ban in banned_str . split ():
        banned [ban] = 1

    #
    # Extract all words from the paragraphs, where words are defined
    # as sequences of letters. Since \w matches the underscore, we
    # will first replace all underscores with spaces first
    #
    words = re . findall (r"\w+", re . sub ("_", " ", paragraph))

    #
    # For each word, it it's not banned, count it in the ok dictionary
    #
    ok = {}
    for word in words:
        if not word in banned:
            if not word in ok:
                ok [word] = 0
            ok [word] = ok [word] + 1

    #
    # Find the word which occurs most frequently
    #
    max = ""
    ok [max] = 0
    for word in ok:
        if ok [word] > ok [max]:
            max = word

    print (max)
