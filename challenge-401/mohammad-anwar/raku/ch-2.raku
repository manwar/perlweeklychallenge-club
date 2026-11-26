#!/usr/bin/env raku

use Test;

my @examples =
    { in => "zroezerotwotwotwo", out => "00222" },
    { in => "sveeeinght",        out => "78"    },
    { in => "onenineninefive",   out => "1599"  },
    { in => "zeroonetwothreeeightfivesixsevenninefour", out => "0123456789" },
    { in => "ninenineninenine",  out => "9999"  },
;

is extract-digits($_<in>), $_<out> for @examples;

done-testing;

sub extract-digits($str) {
    my %c;
    %c{$_}++ for $str.comb;

    my %n =
        0 => %c<z> // 0,
        2 => %c<w> // 0,
        4 => %c<u> // 0,
        6 => %c<x> // 0,
        8 => %c<g> // 0,
    ;
    %n{1} = (%c<o> // 0) - %n{0} - %n{2} - %n{4};
    %n{3} = (%c<h> // 0) - %n{8};
    %n{5} = (%c<f> // 0) - %n{4};
    %n{7} = (%c<s> // 0) - %n{6};
    %n{9} = (%c<i> // 0) - %n{5} - %n{6} - %n{8};

    return (0..9).map({ "$_" x %n{$_} }).join;
}
