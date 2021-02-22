#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

ok 0==system("perl perl/ch-1.pl -test");

for ([XXXIX => 39], [CCXLVI => 246], [DCCLXXXIX => 789], [MMCDXXI => 2421],
     [CLX => 160], [CCVII => 207], [MIX => 1009], [MLXVI => 1066],
     [MDCCLXXVI => 1776], [MCMXVIII => 1918], [MCMLIV => 1954], [MMXIV => 2014]) {
    my($roman, $arabic) = @$_;

    is capture("perl perl/ch-1.pl $roman"),     "$roman => $arabic\n";
    is capture("perl perl/ch-1.pl $arabic"),    "$arabic => $roman\n";
}

is capture("perl perl/ch-2.pl DwAyNE DuANE"),   "0.16\n";
is capture("perl perl/ch-2.pl TRATE  TRACE"),   "0.0933333333333333\n";
is capture("perl perl/ch-2.pl arnab  aranb"),   "0.0533333333333335\n";


done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
