#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read line
do    echo "${line//e/E}"   # Replace all 'e's with 'E'; print result.
      ees="${line//[^e]}"   # Remove anything which is not an 'e'.
      echo "${#ees}"        # Print the number of the ees.
done
