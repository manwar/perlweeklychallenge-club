#!/usr/bin/raku
use experimental :cached;

sub postfix:<!>($n) is cached { $n == 0 ?? 1 !! $n * postfix:<!>($n - 1) }

sub MAIN(
    $n
) {
    say $n.comb.map({ $_! }).sum == $n ?? 1 !! 0;
}
