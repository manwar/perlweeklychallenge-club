#!/usr/bin/env raku

use Test;

my @examples = (
    ["1st Jan 2025",  "2025-01-01"],
    ["22nd Feb 2025", "2025-02-22"],
    ["15th Apr 2025", "2025-04-15"],
    ["23rd Oct 2025", "2025-10-23"],
    ["31st Dec 2025", "2025-12-31"],
);

is(format-date($_[0]), $_[1]) for @examples;

done-testing;

sub format-date(Str $str) {
    $str ~~ /(\d+) \w**2 \s (\w**3) \s (\d+)/;
    sprintf("%04d-%02d-%02d", $2, 1+index("JanFebMarAprMayJunJulAugSepOctNovDec", $1)/3, $0);
}
