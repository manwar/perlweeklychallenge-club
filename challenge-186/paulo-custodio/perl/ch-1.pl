#!/usr/bin/env perl

# Perl Weekly Challenge 186 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-186/

use Modern::Perl;
use List::Util qw( unpairs zip );

@ARGV==2 or die "usage: ch-1.pl list1 list2\n";
say "(", join(", ", unpairs(zip(map {[split ' ', $_]} @ARGV))), ")";
