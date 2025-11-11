#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    ["1st Jan 2025",  "2025-01-01"],
    ["22nd Feb 2025", "2025-02-22"],
    ["15th Apr 2025", "2025-04-15"],
    ["23rd Oct 2025", "2025-10-23"],
    ["31st Dec 2025", "2025-12-31"],
);

is(format_date($_->[0]), $_->[1]) for @examples;

done_testing;

sub format_date {
    my $str = shift;
    $str =~ /(\d+)\w{2} (\w{3}) (\d+)/;
    sprintf("%04d-%02d-%02d", $3, 1+index("JanFebMarAprMayJunJulAugSepOctNovDec",$2)/3, $1);
}
