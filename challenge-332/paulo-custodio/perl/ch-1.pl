#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 yyyy-mm-dd\n";
my($y, $m, $d) = split /-/, $ARGV[0];
printf("%b-%b-%b\n", $y, $m, $d);
