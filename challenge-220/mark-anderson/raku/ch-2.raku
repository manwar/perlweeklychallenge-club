#!/usr/bin/env raku
use Test;

is-deeply squareful(1, 17, 8), ((1, 8, 17), (17, 8, 1));
is-deeply squareful(2, 2, 2),  ((2, 2, 2),);

sub squareful(+@a)
{
    gather for @a.permutations.unique(with => &[eqv])
    {
        .take if all(.rotor(2 => -1)).sum.sqrt.narrow ~~ UInt 
    }
}

=begin alternate
sub squareful(+@a)
{
    my $s = @a.sort.tail(2).sum;

    my $squares := (0..$s Z* 0..$s).List;

    gather for @a.permutations.unique(with => &[eqv])
    {
        .take if .rotor(2 => -1)>>.sum (<=) $squares
    }
}
=end alternate
