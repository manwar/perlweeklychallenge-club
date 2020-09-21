#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#
# Comments: 
#
# This is atraightforwad but slow (for big input numbers) solution.
#
# Output:
#
# $ raku ch-1a.raku 42
# 108
#
# $ raku ch-1a.raku 500
# 2222

my $n = @*ARGS[0] // 42;

say [+] ((.base(2) ~~ m:g/1/).elems for 1..$n);
