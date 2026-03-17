#!/usr/bin/env perl

# Perl Weekly Challenge 330 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/

use Modern::Perl;
use List::Util qw(uniq);

@ARGV==1 or die "usage: $0 str\n";
my $str = $ARGV[0];
1 while $str =~ s/\D\d//;
say $str;
