#!/usr/bin/env raku

use Test;
plan 2;

is nth-root(5, 248832), 12;
is nth-root(5, 34),     2.02;

sub nth-root($n, $k) 
{
    my $x = .narrow given $k ** (1/$n); 

    unless $x ~~ UInt
    {
        $x .= fmt("%.2f");
    }

    $x;
}
