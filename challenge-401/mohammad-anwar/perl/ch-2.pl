#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in  => "zroezerotwotwotwo", out => "00222" },
    { in  => "sveeeinght",        out => "78"    },
    { in  => "onenineninefive",   out => "1599"  },
    { in  => "zeroonetwothreeeightfivesixsevenninefour", out => "0123456789" },
    { in  => "ninenineninenine",  out => "9999"  },
);

is extract_digits($_->{in}), $_->{out} foreach @examples;

done_testing;

sub extract_digits($str) {
    my %c;
    $c{$_}++ for split //, $str;

    my %n = (
        0 => $c{z} // 0,
        2 => $c{w} // 0,
        4 => $c{u} // 0,
        6 => $c{x} // 0,
        8 => $c{g} // 0,
    );
    $n{1} = ($c{o} // 0) - $n{0} - $n{2} - $n{4};
    $n{3} = ($c{h} // 0) - $n{8};
    $n{5} = ($c{f} // 0) - $n{4};
    $n{7} = ($c{s} // 0) - $n{6};
    $n{9} = ($c{i} // 0) - $n{5} - $n{6} - $n{8};

    return join '', map { "$_" x $n{$_} } 0 .. 9;
}
