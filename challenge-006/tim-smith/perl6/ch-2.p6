#! /usr/bin/env perl6

# https://en.wikipedia.org/wiki/Heegner_number#Almost_integers_and_Ramanujan's_constant

# Ramanujan's constant is _almost_ this integer ...
my $r = 640_320 ** 3 + 744;

# But is off by an error which is defined in terms of the constant itself,
# so this approximation is close enough for at least 32 significant digits.
$r += FatRat.new: -196_844, $r;

put substr($r, 0, 33);
