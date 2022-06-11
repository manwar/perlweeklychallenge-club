#!/usr/bin/env raku

use Test;

# only run tests where the Pisano Period is <= max
my \max = 500;
my $fibs := (0, 1, * + * ... *).head(max + max).List;

# b001175.txt can be downloaded here https://oeis.org/A001175/b001175.txt
for 'b001175.txt'.IO.lines
{
    my ($n, $a) = .split(/\s/);
    next if $a > max;
    is pisano-period(+$n), $a, "pisano-period($n) == $a";
}

sub pisano-period(\n)
{
    my $mods := eager $fibs.map(* mod n);

    for 1..max
    {
        my $r := $mods.rotor($_).List;
        return $r.head.elems if [eqv] $r;
    }
}
