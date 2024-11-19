#! /usr/bin/raku

use Test;

plan 4;

is(matchsticksquare([1, 2, 2, 2, 1]), True, 'example 1');
is(matchsticksquare([2, 2, 2, 4]), False, 'example 2');
is(matchsticksquare([2, 2, 2, 2, 4]), False, 'example 3');
is(matchsticksquare([3, 4, 1, 4, 3, 1]), True, 'example 4');

sub matchsticksquare(@a) {
    my $perimeter = @a.sum;
    if $perimeter % 4 != 0 {
        return False;
    }
    my $side = $perimeter / 4;
    my @ss = @a.sort({$^b <=> $^a});
    my $sidesleft = 4;
    my $lengthleft = $side;
    loop {
        my @leftover;
        for @ss -> $m {
            if $m > $side {
                return False;
            }
            if $m <= $lengthleft {
                $lengthleft -= $m;
                if $lengthleft == 0 {
                    $sidesleft--;
                    $lengthleft = $side;
                }
            } else {
                @leftover.push($m);
            }
        }
        if @leftover.elems == 0 {
            last;
        }
        @ss = @leftover;
    }
    $sidesleft == 0 && $lengthleft == $side;
}
