#!/usr/bin/env raku
use v6.d;

#
# Copyright © 2024 Joelle Maslak
#

sub MAIN(Str:D $str where $str.chars > 0, Str:D $char where $char.chars == 1) {
    my $charcount = $str.comb.grep($char);
    printf("Percentage of times character apears in string %.0f%%\n", 100.0*$charcount/$str.chars);
}


