#!/usr/bin/env perl

# Challenge 110
#
# TASK #1 - Valid Phone Numbers
# Submitted by: Mohammad S Anwar
# You are given a text file.
#
# Write a script to display all valid phone numbers in the given text file.
#
# Acceptable Phone Number Formats
# +nn  nnnnnnnnnn
# (nn) nnnnnnnnnn
# nnnn nnnnnnnnnn
# Input File
# 0044 1148820341
#  +44 1148820341
#   44-11-4882-0341
# (44) 1148820341
#   00 1148820341
# Output
# 0044 1148820341
#  +44 1148820341
# (44) 1148820341

use Modern::Perl;
while (<>) {
    print if /^ \s* (?: \+ \d{2} | \( \d{2} \) | \d{4} ) \s+ \d{10} \s* $/x;
}
