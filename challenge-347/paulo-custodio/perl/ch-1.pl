#!/usr/bin/env perl

use Modern::Perl;

@ARGV==3 or die "usage: $0 1st Feb 2025\n";
my($d, $m, $y) = @ARGV;
$d =~ s/\D//g;
my %months = (jan=>1, feb=>2, mar=>3, apr=>4, may=>5, jun=>6,
              jul=>7, aug=>8, sep=>9, oct=>10, nov=>11, dec=>12);
$m = $months{lc($m)};
say sprintf("%04d-%02d-%02d", $y, $m, $d);
