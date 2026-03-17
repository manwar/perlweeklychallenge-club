#!/usr/bin/env perl

# Perl Weekly Challenge 266 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/

use Modern::Perl;

my($line1, $line2) = split /,/, "@ARGV";
my %count;
for my $word (split ' ', "$line1 $line2") {
    $count{$word}++;
}
my @uncommon = sort grep {$count{$_}==1} keys %count;

say "(", join(", ", @uncommon), ")";
