#! /usr/bin/raku

use Test;

plan 2;

is(arrangebinary([1, 0, 0, 0, 1], 1), True, 'example 1');
is(arrangebinary([1, 0, 0, 0, 1], 2), False, 'example 2');

sub arrangebinary(@a, $n) {
    my @b = @a;
    my $t = $n;
    for 0 .. @b.end -> $i {
        if (@b[$i] == 0 &&
                        ($i == 0 || @b[$i - 1] == 0) &&
                        ($i == @b.end || @b[$i + 1] == 0)) {
            @b[$i] = 1;
            $t -= 1;
            if ($t == 0) {
                last;
            }
        }
    }
    $t == 0;
}
