#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ first max };

my @examples = (

    [ 3, 2, 4, 1 ],
    [ 2, 1, 2, 3, 3, 3, 5 ],
    [ 1, 3, 2, 3, 3, 3, 5 ],
);

for my $example (@examples) {
    my $output = distribute_elements( $example->@* );
    my ( $x, $y, @ints ) = $example->@*;
    my $ints = join ', ', @ints;

    say <<"END";
        Input:  \@ints = ($ints), \$x = $x, \$y = $y
        Output: $output
END
}

sub distribute_elements (@input) {
    my ( $x, $y, @ints ) = @input;
    my $max   = max @ints;
    my $count = scalar grep { $_ < $max } @ints;
    my $cost  = 0;
    my $check = $x * 2 >= $y ? 1 : 0;
    while ($count) {
        if ( $check && $count > 1 ) {
            my $f = first { $ints[$_] < $max } 0 .. -1 + scalar @ints;
            my $s =
                first { $ints[$_] < $max && $_ != $f } 0 .. -1 + scalar @ints;
            $ints[$f]++;
            $ints[$s]++;
            $cost += $y;
        }
        else {
            my $f = ( first { $ints[$_] < $max } 0 .. -1 + scalar @ints );
            $ints[$f]++;
            $cost += $x;
        }
        $count = scalar grep { $_ < $max } @ints;
    }
    return $cost;
}
