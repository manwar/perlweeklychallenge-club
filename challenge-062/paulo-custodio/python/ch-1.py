#!/usr/bin/env python3

# Challenge 062
#
# TASK #1 > Sort Email Addresses
# Submitted by: Neil Bowers
# Reviewed by: Ryan Thompson
#
# Write a script that takes a list of email addresses (one per line) and sorts
# them first by the domain part of the email address, and then by the part to
# the left of the @ (known as the mailbox).
#
# Note that the domain is case-insensitive, while the mailbox part is case
# sensitive. (Some email providers choose to ignore case, but that's another
# matter entirely.)
#
# If your script is invoked with arguments, it should treat them as file names
# and read them in order, otherwise your script should read email addresses from
# standard input.
#
# Bonus
# Add a -u option which only includes unique email addresses in the output, just
# like sort -u.
#
# Example
# If given the following list:
#
# name@example.org
# rjt@cpan.org
# Name@example.org
# rjt@CPAN.org
# user@alpha.example.org
# Your script (without -u) would return:
#
# user@alpha.example.org
# rjt@cpan.org
# rjt@CPAN.org
# Name@example.org
# name@example.org
# With -u, the script would return:
#
# user@alpha.example.org
# rjt@CPAN.org
# Name@example.org
# name@example.org

import sys
from getopt import getopt

opt_u = False
opts, args = getopt(sys.argv[1:], 'u')
for o, a in opts:
    if o == '-u':
        opt_u = True

mails = [line.strip() for line in sys.stdin]

sorted_mails = sorted(
    map(lambda x: [x] + x.split('@'), mails),
    key=lambda x: (x[2].lower(), x[1])
)

if opt_u:
    seen = set()
    sorted_mails = [
        [f"{mail[0]}"]
        for mail in sorted_mails
        if (key := f"{mail[1]}@{mail[2].lower()}") not in seen and not seen.add(key)
    ]

print("\n".join([x[0] for x in sorted_mails]))
