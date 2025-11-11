#!/bin/env raku

unit sub MAIN(Str:D $s, Int:D $tgt);

use MONKEY-SEE-NO-EVAL;

my @s = $s.comb;
my @opers = '+', '-', '*', '';

my @ans;
for [X] @opers xx (+@s-1) -> @ops {
    my $exp = roundrobin(@s, @ops).flat.join;
    next if $exp ~~ /« '0' \d/;    # drop expressions which contains number with a leading 0
    @ans.push($exp) if EVAL($exp) == $tgt;
}
put @ans.join(', ');
