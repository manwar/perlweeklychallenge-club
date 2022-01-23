#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: Rscript ch-1.r
#

cat (grep ("^0$|[1789]|2.|[35]$", c (0:100), invert = TRUE, value = TRUE), "\n")
