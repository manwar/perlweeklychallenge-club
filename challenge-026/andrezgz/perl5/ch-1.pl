#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-026/
# Task #1
# Create a script that accepts two strings, let us call it,
# "stones" and "jewels". It should print the count of "alphabet"
# from the string "stones" found in the string "jewels".
# For example, if your stones is "chancellor" and "jewels" is "chocolate",
# then the script should print "8". To keep it simple,
# only A-Z,a-z characters are acceptable.
# Also make the comparison case sensitive.

use strict;
use warnings;

die "Usage: $0 word1 word2" unless @ARGV == 2;
my ($w1, $w2) = @ARGV;

print scalar                        # print the number
      grep {
          $_ =~ /[A-Za-z]/          # of alphabethic case insensitive characters
          && index($w2, $_) != -1   # that exist on the second word
      } split //, $w1;              # from each one of the first word
