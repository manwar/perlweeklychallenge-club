#!/usr/bin/env raku
use Test;

# I suggested this challenge after seeing it on the list of 
# unimplemented tasks on Rosetta Code. 

# https://rosettacode.org/wiki/Rosetta_Code/Find_unimplemented_tasks#Raku

is-deeply list-division((1..5),  2),  ((1,2,3), (4,5));
is-deeply list-division((1..6),  3),  ((1,2), (3,4), (5,6));
is-deeply list-division((1..3),  2),  ((1,2), (3,));
is-deeply list-division((1..10), 5),  ((1,2), (3,4), (5,6), (7,8), (9,10));
is        list-division((1..3),  4),  -1;
is-deeply list-division((72,57,89,55,36,84,10,95,99,35), 7), ((72,57), (89,55), (36,84), (10,), (95,), (99,), (35,));

say list-division-v2((72,57,89,55,36,84,10,95,99,35), 7);

multi list-division($l, $n where * > $l) { -1 }

multi list-division($l, $n)
{
    my ($a, $b) = $l.elems.polymod($n);
    $l.rotor(flat ($b+1 xx $a), ($b xx $n-$a))
}

# This is a regex solution but it's unusable for large $l and large $n.
sub list-division-v2($l, $n)
{
    my $c = $l div $n;
    $l ~~ m/[$<result> = [\d+] ** {$c..$c+1} % \s] ** {$n} % \s/; 
    $<result>
}
