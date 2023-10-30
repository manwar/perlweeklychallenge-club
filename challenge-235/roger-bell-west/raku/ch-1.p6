#! /usr/bin/raku

use Test;

plan 3;

is(removeone([0, 2, 9, 4, 6]), True, 'example 1');
is(removeone([5, 1, 3, 2]), False, 'example 2');
is(removeone([2, 2, 3]), True, 'example 3');

sub removeone(@a) {
    my $ec = 0;
    my $le = 1 + @a[1] - @a[0];
    for @a.rotor(2 => -1) -> @s {
        if (@s[1] <= @s[0]) {
            $ec++;
            if ($ec > 1 || @s[0] - @s[1] >= $le) {
                return False;
            }
        }
        $le = @s[1] - @s[0];
    }
    return True;
}
