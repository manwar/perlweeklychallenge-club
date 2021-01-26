#!/usr/bin/perl

# Challenge 001
#
# Challenge #1
# Write a script to replace the character ‘e’ with ‘E’ in the string
# ‘Perl Weekly Challenge’. Also print the number of times the character ‘e’
# is found in the string.

use strict;
use warnings;
use 5.030;

my $s = @ARGV ? "@ARGV" : "Perl Weekly Challenge";
say(($s =~ tr/e/E/), " ", $s);
