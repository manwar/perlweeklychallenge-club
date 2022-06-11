#! /usr/bin/perl6

use Test;

plan 2;

is(planloot([2, 4, 5]),7,'example 1');

is(planloot([4, 2, 3, 6, 5, 3]),13,'example 2');

sub planloot(@houses) {
    my $terminal=@houses.elems-2;
    my @b=[[0]];
    my $reward=0;
    while (@b.elems > 0) {
        my @c=(pop @b).flat;
        if (@c[*-1] >= $terminal) {
            $reward=max($reward,sum(map {@houses[$_]}, @c));
        } else {
            for @c[*-1]+2..@c[*-1]+3 -> $n {
                if ($n >= @houses.elems) {
                    last;
                }
                my @j=@c.clone;
                @j.append($n);
                push @b,@j;
            }
        }
    }
    return $reward;
}
