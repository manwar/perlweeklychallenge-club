#!/usr/bin/env raku
#`{
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-01
Challenge 206 Array Pairings ( Raku )
----------------------------------------
}

use v6;

my @arrs = ([1,2,3,4],[0,2,1,3]);
my @pairs = ([0,1,2,3], [0,2,1,3], [0,3,1,2]);
my $maxval = 0;

for (@arrs) -> @a {
    say "Input: \@array = ",@a;
    for (@pairs)  -> @p {
        #$maxval = 0;

        my @a1 = @p[0..1];
        my $val1 = @a[@a1].min;

        my @a2 = @p[2..3];
        my $val2 = @a[@a2].min;

        my $sum = $val1 + $val2;
        if $sum > $maxval {
            $maxval = $sum;
        }
    }
    say $maxval;
    say " ";
    $maxval = 0;
}

#`{
----------------------------------------
SAMPLE OUTPUT
raku .\ArrayPairings.rk
Input: @array = [1 2 3 4]
4

Input: @array = [0 2 1 3]
2
----------------------------------------
}
