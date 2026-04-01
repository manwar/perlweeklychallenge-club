#!/usr/bin/env perl

# Perl Weekly Challenge 180 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-180/

use Modern::Perl;

my @chars = split //, "@ARGV";
my %count; $count{$_}++ for @chars;
my $pos = (map {$_->[0]} grep {$_->[1] == 1} map {[$_, $count{$chars[$_]}]}
           0..$#chars)[0];
say $pos;
