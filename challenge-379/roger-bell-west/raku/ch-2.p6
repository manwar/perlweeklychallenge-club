#! /usr/bin/raku

use Test;

plan 3;

is-deeply(armstrongnumber(10, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407], 'example 1');
is-deeply(armstrongnumber(7, 1000), [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250], 'example 2');
is-deeply(armstrongnumber(16, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645], 'example 3');

sub armstrongnumber($base, $limit) {
    my @out;
    for 0 .. $limit - 1 -> $candidate {
        my @digits;
        if ($candidate == 0) {
            @digits.push(0);
        } else {
            my $c = $candidate;
            while ($c > 0) {
                @digits.push($c % $base);
                $c = $c div $base;
            }
        }
        my $dl = @digits.elems;
        my $test = @digits.map({$_ ** $dl}).sum;
        if ($test == $candidate) {
            @out.push($candidate);
        }
    }
    @out;
}
