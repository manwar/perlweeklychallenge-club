#!/usr/bin/env raku
use Test;

is-deeply decode-counts(11),   < AA K >;
is-deeply decode-counts(1115), < AAAE AAO AKE KAE KO >;
is-deeply decode-counts(127),  < ABG LG >;

# Not sure how to deal with zeros but this is what the program does.
is-deeply decode-counts(1002001), < ABA ATA JBA JTA >;

sub decode-counts($n)
{
    sub composition($_)
    {
        gather .fmt('%0' ~ $n.chars ~ 'b') ~~ m:g/(.)$0* <?{ take $/.pos - $/.from }>/
    }

    sort map
    { 
        my $c := $n.comb.rotor(composition($_))>>.join>>.Int;
        next unless all($c) ~~ 1..26;
        [~] $c.map({ chr($_+64) });
    }, ^2**($n.chars-1) 
}
