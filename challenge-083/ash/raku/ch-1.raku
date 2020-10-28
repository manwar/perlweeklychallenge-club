#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-083/

# Output:
# $ raku ch-1.raku 
# 23

my $s = 'The purpose of our lives is to be happy';
# my $s = 'The Weekly Challenge';

$s.words[1 .. *-2]>>.chars.sum.say;
