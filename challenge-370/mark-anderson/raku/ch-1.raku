#!/usr/bin/env raku
use Test;

is popular-word("Bob hit a ball, the hit BALL flew far after it was hit.", [< hit >]),        "ball";
is popular-word("Apple? apple! Apple, pear, orange, pear, apple, orange.", < apple pear >),   "orange";
is popular-word("A. a, a! A. B. b. b.", [< b >]),                                             "a";
is popular-word("Ball.ball,ball:apple!apple.banana", [< ball >]),                             "apple";
is popular-word("The dog chased the cat, but the dog was faster than the cat.", < the dog >), "cat";

sub popular-word($str, @banned)
{
    my $bag = ($str.trans: ('A'..'Z', /<punct>/) => ('a'..'z', ' ')).words.BagHash;
    $bag{@banned}:delete;
    $bag.max(*.value).key
}
