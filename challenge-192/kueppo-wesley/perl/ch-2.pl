#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use List::Util qw/ sum /;

sub equalize {
    my @list = @_;
    my $sum  = sum @list;

    # Cannot equally distribute without using floating points, so return.
    return -1 if $sum % @list != 0;

    my $move   = 0;
    my $target = $sum / @list;

    while ( my ( $i, $v ) = each @list ) {

        # Well, get this: no matter what, in the last iteration we are
        # pretty pretty sure that `$v' is gonna be `$target'
        next if $v == $target;

        if ( $v < $target ) {
            foreach my $j ( $i + 1 .. $#list ) {
                if ( $list[$j] > $target ) {
                    my $strip = $target - $v;

                    $list[$j] -= $strip;
                    $move += ( $j - $i ) * $strip;
                    last;
                }
            }
        }
        else {
            my $step = $v - $target;

            $move += $step;

            # and as a result we are never gonna overflow.
            $list[ $i + 1 ] += $step;
        }

        $list[$i] = $target;
    }

    return $move;
}

my %test_data = (
                  expected => [ 4,           -1,          2,           21 ],
                  samples  => [ [ 1, 0, 5 ], [ 0, 2, 0 ], [ 0, 3, 0 ], [ 9, 9, 2, 4, 1 ] ],
);

is_deeply( [ map { equalize(@$_) } $test_data{samples}->@* ], $test_data{expected}, "Equalized?" );

done_testing(1);
