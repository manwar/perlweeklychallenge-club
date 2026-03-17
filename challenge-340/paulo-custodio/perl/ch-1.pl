#!/usr/bin/env perl

# Perl Weekly Challenge 340 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-340/

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
my $string = $ARGV[0];
1 while $string =~ s/(.)\1//;
say $string;
