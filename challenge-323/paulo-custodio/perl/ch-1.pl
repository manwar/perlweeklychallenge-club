#!/usr/bin/env perl

# Perl Weekly Challenge 323 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-323/

use Modern::Perl;

@ARGV or die "usage: $0 ops\n";
my $ops = "@ARGV";
my $total = (($ops =~ tr/+/+/) - ($ops =~ tr/-/-/)) / 2;
say $total;
