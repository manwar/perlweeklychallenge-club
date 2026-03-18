#!/usr/bin/env perl

# Perl Weekly Challenge 359 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/

use Modern::Perl;

@ARGV==1 or die "usage:$0 str\n";
my $str = $ARGV[0];
1 while $str =~ s/(.)\1//;
say $str;
