#! /usr/bin/raku

use Test;

plan 3;

is(thirtythreepercentappearance([1, 2, 3, 3, 3, 4, 2]), 3, 'example 1');
is(thirtythreepercentappearance([1, 1]), 1, 'example 2');
is(thirtythreepercentappearance([1, 2, 3]), 1, 'example 3');

sub thirtythreepercentappearance(@a) {
    my %c;
    for @a -> $n {
        %c{$n}++;
    }
    my $threshold=Int.new(@a.elems * 33 / 100);
    if (Int.new($threshold * 100 / 33) != @a.elems) {
        $threshold++;
    }
    my @s = %c.keys.grep({%c{$_} >= $threshold});
    if (@s.elems > 0) {
        return @s.min;
    } else {
        return Int.new;
    }
}
