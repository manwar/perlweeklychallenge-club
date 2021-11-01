#!/usr/bin/env raku

use Test;
plan 4;

is lychrel(56),  0, 'Example 1';
is lychrel(57),  0, 'Example 2';
is lychrel(59),  0, 'Example 3';
is lychrel(196), 1, 'Smallest Lychrel';

sub lychrel($n is copy where 10 <= $n <= 1000)
{
    loop
    {
        my $sum = $n + $n.flip;

        return 0 if $sum eq $sum.flip;
        return 1 if ++$  == 500;
        return 1 if $sum >= 10e6;

        $n = $sum;
    }
} 
