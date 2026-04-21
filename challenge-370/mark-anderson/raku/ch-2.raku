#!/usr/bin/env raku
use Test;

ok  scramble-string("abc", "acb");
ok  scramble-string("abcd", "cdba");
nok scramble-string("hello", "hiiii");
ok  scramble-string("ateer", "eater");
nok scramble-string("abcd", "bdac");

sub scramble-string($a, $b)
{
    my $c = $b.flip;

    for 1..^$a.chars -> $i
    {
        my $a-rx = $a ~~ / (. ** {$i}) (.*) /;
        my $b-rx = $b ~~ / (. ** {$i}) (.*) /;
        my $c-rx = $c ~~ / (. ** {$i}) (.*) /;

        return True if any all($a-rx[0].comb.Bag eqv $b-rx[0].comb.Bag,
                               $a-rx[1].comb.Bag eqv $b-rx[1].comb.Bag),
                           all($a-rx[0].comb.Bag eqv $c-rx[0].comb.Bag,
                               $a-rx[1].comb.Bag eqv $c-rx[1].comb.Bag)
    }

    return False
}
