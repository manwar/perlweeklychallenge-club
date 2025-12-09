#! /usr/bin/raku

use Test;

plan 5;

is(arithmeticprogression([1, 3, 5, 7, 9]), True, 'example 1');
is(arithmeticprogression([9, 1, 7, 5, 3]), True, 'example 2');
is(arithmeticprogression([1, 2, 4, 8, 16]), False, 'example 3');
is(arithmeticprogression([5, -1, 3, 1, -3]), True, 'example 4');
is(arithmeticprogression([1.5, 3, 0, 4.5, 6]), True, 'example 5');

sub arithmeticprogression(@a0) {
    my $epsilon = 0.0001;
    my @a = @a0.sort({$^a <=> $^b});
    my $delta = @a[1] - @a[0];
    for @a.skip(2).rotor(2 => -1) -> @v {
        if (abs(@v[1] - @v[0] - $delta) > $epsilon) {
            return False;
        }
    }
    return True;
}
