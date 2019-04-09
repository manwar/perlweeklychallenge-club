#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/a-new-week-a-new-challenge/
# Challenge #1
# Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly Challenge’.
# Also print the number of times the character ‘e’ found in the string.

use strict;

my $str = 'Perl Weekly Challenge';

my $c = ($str =~ tr/e/E/);

print $str . ' had ' . $c . ' e\'s that were replaced by E\'s';
