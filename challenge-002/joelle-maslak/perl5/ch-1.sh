#!/bin/bash

# Challenge:
#   Write a script or one-liner to remove leading zeros from positive
#   numbers.
#
# Assumptions:
#   The first question was, "What do you do about non-positive numbers?
#
#     I assumed we just wanted to print non-numbers or non-positive
#     numbers "as-is", without removing anything. But we still wanted to
#     handle them, otherwise this would be a shorter program.
#
#     Zero is neither postiive or negative.
#
#   Likewise, what is a number?
#
#     I assumed any number that is provided in decimal format is a
#     number. Numbers expressed in scientific notation, non-latan
#     script, or fractions (1/2) are not treated as positive numbers, so
#     they are printed without modification.
#
#   Example input/output
#
#     INPUT     OUTPUT
#     0         0
#     0.0       0.0
#     00.00     00.00
#     -1        -1
#     -01       -01
#     1.0       1.0
#     1.0000    1.0000
#     00.       00.         (not a standard-formatted number)
#     0.0       .0          (leading zero removed)
#     001       1
#     abc       abc
#     01a       01a
#     001 2     001 2
#
# Implementation:
#   "perl -E" simply executes the first argument, the script.  We'll
#   describe the script later.  The "--" argument just tells Perl to not
#   treat any following arguments as Perl runtime arguments (I.E.
#   instaed of perl trying to interpret -1 as a command line argument,
#   we want to just pass it to the script.  The final argument, "$*", is
#   just the arguments passed to this shell script, passed as the first
#   argument to the one-liner.
#
#   The script used takes the first command line parameter (shift) and
#   does a substitution on it.  The regex substitution uses the "rsxx"
#   modifiers.  The "a" modifier says to treat character classes as if
#   they only match ASCII characters - thus \d becomes equivilent to
#   [0-9] rather than 0-9 plus all digits in other scripts.  The "r"
#   modifier says to not modify the input argument, just return the
#   modified result.  The "s" says to treat this as a single line
#   statement (it either matches or it doesn't with the complete
#   string).  The "xx" allows us to use whitespace to make the regex
#   more readable.
#
#   The regex basically removes zeros at the front of one of two
#   different patterns - this pattern could be simplified as two
#   regexes:
#
#     s/ ^ 0+ ( \d* \. \d+ ) $ /$1/arsxx
#     
#       - and -
#
#     s/ ^ 0+ ( [1-9] \d* ) $ /$1/arsxx
#
#   The first one handles numbers with a decimal point.  It removes all
#   leading zeros in front of the decimal point, in a pretty
#   straightforward way.  Note that 0.0 would become .0, removing the
#   leading zero.
#
#   The second regex above handles non-zero positive numbers without a
#   decimal point.  But we don't want to remove leading zeros for zero
#   itself.  I.E. 00 is not a positive number (it's zero, it's neither
#   positive or negative), so it should stay 00.  So any number starting
#   with a zero must have at least one non-zero digit for leading zeros
#   to be removed.
#
#   These two regexes were then combined form what is in the one-liner
#   below.
#   
perl -E 'say shift =~ s/ ^ 0+ ( ( \d* \. \d+ ) | ( [1-9] \d* ) ) $ /$1/arsxx' -- "$*"

