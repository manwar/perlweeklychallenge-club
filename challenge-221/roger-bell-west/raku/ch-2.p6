#! /usr/bin/raku

use Test;

plan 3;

is(arithmeticsubsequence([9, 4, 7, 2, 10]), 3, 'example 1');
is(arithmeticsubsequence([3, 6, 9, 12]), 4, 'example 2');
is(arithmeticsubsequence([20, 1, 15, 3, 10, 5, 8]), 4, 'example 3');

sub isas(@a) {
    my $t = @a[1] - @a[0];
    for @a.skip(1).rotor(2 => -1) -> $i {
        if ($i[1] - $i[0]) != $t {
            return False;
        }
    }
    return True;
}

sub arithmeticsubsequence(@ints) {
    my @stack = [ @ints, ];
    while (@stack.elems > 0) {
        my @t = @stack.shift.List;
        if (isas(@t)) {
            return @t.elems;
        } else {
            for (0 .. @t.end) -> $i {
                my @tt;
                for (0 .. @t.end) -> $ix {
                    if ($i != $ix) {
                        @tt.push(@t[$ix]);
                    }
                }
                @stack.push(@tt);
            }
        }
    }
    return 0;
}
