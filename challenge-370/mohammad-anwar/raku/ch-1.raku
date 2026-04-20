#!/usr/bin/env raku

use Test;

my @examples = (
    { in  => ["Bob hit a ball, the hit BALL flew far after it was hit.", "hit"],
      out => "ball", },
    { in  => ["Apple? apple! Apple, pear, orange, pear, apple, orange.", "apple", "pear"],
      out => "orange" },
    { in  => ["A. a, a! A. B. b. b.", "b"],
      out => "a" },
    { in  => ["Ball.ball,ball:apple!apple.banana", "ball"],
      out => "apple" },
    { in  => ["The dog chased the cat, but the dog was faster than the cat.", "the", "dog"],
      out => "cat" },
);

sub most-popular($para, *@banned) {
    my $b = @banned.map(*.lc).Set;
    my %f = $para.lc.comb(/<[a..z]>+/).grep({ $_ ∉ $b }).Bag;
    return %f.pairs.sort({ -.value }).head.key;
}

for @examples -> %ex {
    is most-popular(|%ex<in>), %ex<out>;
}

done-testing;
