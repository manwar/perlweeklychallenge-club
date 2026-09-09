#!/bin/env raku

unit sub MAIN(UInt:D $n);

my %candidates = (1..$n).map(-> $m { $m => (1..$n).grep(-> $p { $p != $m && is-square($p + $m) }).Set });
put solve([1], (1..$n).SetHash).join(',');

sub is-square(UInt:D $n --> Bool:D) {
    my $m = $n.sqrt.Int;
    $m * $m == $n
}

sub solve(@queue, SetHash $numbers --> Array:D) {
    if +@queue == $n {
        when is-square(@queue[0] + @queue[$n-1]) { return @queue.Array }
        default                                  { return [] }
    }

    for %candidates{@queue.tail}.keys».Int.sort -> $n {
        next if $n.Int (elem) @queue;

        my @queue_ = |@queue, $n;
        my $numbers_ = $numbers.clone;
        $numbers_.unset($n);
        my @a = solve(@queue_, $numbers_);

        return @a if +@a > 0;
    }

    []
}
