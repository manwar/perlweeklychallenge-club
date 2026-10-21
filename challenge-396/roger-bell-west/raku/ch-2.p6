#! /usr/bin/raku

use Test;

plan 5;

is(trionicarray([1, 3, 5, 4, 2, 6, 8]), True, 'example 1');
is(trionicarray([1, 4, 4, 2, 1, 3, 5]), False, 'example 2');
is(trionicarray([2, 10, 3, 1, 9]), True, 'example 3');
is(trionicarray([1, 2, 3, 4, 3, 2, 1]), False, 'example 4');
is(trionicarray([1, 3, 2, 4, 1, 5, 2]), False, 'example 5');

sub trionicarray(@a) {
    my $state = 0;
    my $prev = @a[0];
    for @a.skip(1) -> $n {
        my $dir = 0;
        if ($n > $prev) {
            $dir = 1;
        } elsif ($n < $prev) {
            $dir = -1;
        }
        if ($dir == 0) {
            return False;
        }
        given $state {
            when 0 {
                if ($dir == 1) {
                    $state = 1;
                } else {
                    return False;
                }
            }
            when 1 {
                if ($dir == -1) {
                    $state = 2;
                }
            }
            when 2 {
                if ($dir == 1) {
                    $state = 3;
                }
            }
            when 3 {
                if ($dir == -1) {
                    return False;
                }
            }
            default {
                return False;
            }
        }
        $prev = $n;
    }
    $state == 3;
}
