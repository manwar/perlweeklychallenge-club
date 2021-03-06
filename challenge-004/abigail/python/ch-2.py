#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-2.py < input-file
#

import fileinput
import getopt
import sys

#
# Parse options
#
opts, args = getopt . getopt (sys . argv [1:], 'f:')
for opt, val in opts:
    if   opt == "-f":
        filename = val


#
# Find the words in 'filename' which can be constructed
# from the letters in 'letters'.
#
def find_words (filename, letters):
    letters = list (letters . lower () . strip ())
    for word in open (filename):
        word = word . strip ()
        copy = word . lower ()
        for letter in letters:
            copy = copy . replace (letter, "", 1)
        if copy == "":
            print (word)


for line in fileinput . input ('-'):
    find_words (filename, line . strip ())
