#!/usr/bin/env perl

use Modern::Perl;

my $n = shift || 0;
die "Usage: ch-2.pl N\n" if $n < 1;

my @half = 1..int($n/2);
my @out = ((reverse map {-$_} @half), (($n % 2 == 1) ? (0) : ()), (@half));
say "(", join(", ", @out), ")";
