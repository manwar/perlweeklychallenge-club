# https://perlweeklychallenge.org/blog/perl-weekly-challenge-019/
# Task #1
# Write a script to accept a string from command line and split it on change of character.
# For example, if the string is "ABBCDEEF", then it should split like "A", "BB", "C", "D", "EE", "F".
perl -e 'while ($ARGV[0] =~ /(([A-Z])\2*)/g) { print "$1\n"; };' $1
