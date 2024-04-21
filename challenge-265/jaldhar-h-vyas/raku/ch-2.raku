#!/usr/bin/raku

sub MAIN(
    $str, *@str
) {
    my @letters = $str.lc.comb.grep({ $_ ~~ <a> .. <z> }).Bag;
    @str.grep({ @letters ⊆ $_.comb.Bag }).sort({ $^a.chars <=> $^b.chars }).first.say;
}