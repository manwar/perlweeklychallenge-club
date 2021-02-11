#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f
shopt -u extglob

#
# Read a string and a pattern from standard input.
# Escape any [ in the pattern.
# Remove whatever is matched by the pattern from the string.
# If the result is empty, we have a match, else, we do not.
#
while read string pattern
do    string=${string/${pattern//\[/\\[}/}
      echo $((${#string} == 0 ? 1 : 0))
done
