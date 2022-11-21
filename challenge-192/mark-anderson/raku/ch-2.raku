#!/usr/bin/env raku
use Test;

is equal-distribution(< 1 0 5 >),     4;
is equal-distribution(< 0 2 0 >),    -1;
is equal-distribution(< 0 3 0 >),     2;
is equal-distribution(< 1 0 2 5 7 >), 17;
is equal-distribution(< 1 0 5 2 7 >), 14;
is equal-distribution([1..101]),      85850;
is equal-distribution([101...1]),     85850;

# Thanks to scimon, drbaggy, and others for simplifying this for me :)

sub equal-distribution(*@a)
{
    my $avg = @a.sum / @a.elems;
    return -1 unless $avg.narrow ~~ Int;
    my $moves;

    for @a.rotor(2 => -1)
    {
         my $n  = $avg - .[0];
        .[0]   += $n;
        .[1]   -= $n;
        $moves += abs($n)
    }
 
    $moves
} 
