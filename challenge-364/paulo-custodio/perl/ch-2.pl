#!/usr/bin/env perl

# Perl Weekly Challenge 364 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
$_ = shift;
s/\(\)/o/g;
s/\(al\)/al/g;
say $_;
