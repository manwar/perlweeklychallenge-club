#!/usr/bin/perl

# Challenge 028

# Task #1
# Write a script to check the file content without explicitly reading the
# content. It should accept file name with path as command line argument and
# print "The file content is binary." or else "The file content is ascii."
# accordingly.

import sys

file = sys.argv[1]
if b'\x00' in open(file, 'rb').read():
    print("The file content is binary.")
else:
    print("The file content is ascii.")
