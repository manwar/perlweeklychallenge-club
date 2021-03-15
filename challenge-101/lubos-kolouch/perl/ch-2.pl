#!/usr/bin/perl
# I solved this some time ago for Project Euler #102, copying

#
use strict;
use bigrat;


sub has_origin {
    my $what = shift;

    (my $x1,my $y1,my $x2,my $y2,my $x3,my $y3)= @$what;

    my $va2 = -1*($x2-$x1);
    my $va1 = $y2-$y1;

    my $c = $x1*$va1+$y1*$va2;
    $c=-$c;

    my $calc1=$va1*$x3+$va2*$y3+$c;

    if ($calc1*$c>=0)
    {

        $va2 = -1*($x3-$x1);
        $va1 = $y3-$y1;

        $c = $x1*$va1+$y1*$va2;
        $c=-$c;

        $calc1=$va1*$x2+$va2*$y2+$c;

        if ($calc1*$c>=0)
        {
            $va2 = -1*($x3-$x2);
            $va1 = $y3-$y2;

            $c = $x2*$va1+$y2*$va2;
            $c=-$c;

            $calc1=$va1*$x1+$va2*$y1+$c;
            return 1 if ($calc1*$c>=0);
        }
    }

    return 0;
}

use Test::More;

is(has_origin([0,1,1,0,2,2]), 0);
is(has_origin([1,1,-1,1,0,-3]), 1);
is(has_origin([0,1,2,0,-6,0]), 1);
done_testing;
