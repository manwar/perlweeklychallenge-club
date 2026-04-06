#!/usr/bin/env perl

# Perl Weekly Challenge 180 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-180/

use Modern::Perl;

@ARGV>2 or die "usage: ch-2.pl list... i\n";
my @list = @ARGV;
my $i = pop(@list);
say "(", join(", ", grep {$_ > $i} @list), ")";
