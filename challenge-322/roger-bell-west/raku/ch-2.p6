#! /usr/bin/raku

use Test;

plan 3;

is-deeply(rankarray([55, 22, 44, 33]), [4, 1, 3, 2], 'example 1');
is-deeply(rankarray([10, 10, 10]), [1, 1, 1], 'example 2');
is-deeply(rankarray([5, 1, 1, 4, 3]), [4, 1, 1, 3, 2], 'example 3');

sub rankarray(@a) {
    my @b = Set.new(@a).keys.sort({ $^a <=> $^b });
    my %c;
    for @b.kv -> $i, $n {
        %c{$n} = $i + 1;
    }
    my @out;
    for @a -> $v {
        @out.push(%c{$v});
    }
    @out;
}
