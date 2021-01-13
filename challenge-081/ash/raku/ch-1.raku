#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-081/

# Test run:
#
# $ raku ch-1.raku abcdabcd abcdabcdabcdabcd
# abcd
# abcdabcd

unit sub MAIN(Str $a is copy, Str $b is copy);

# Make sure that $a is not longer than $b
($a, $b) = $b, $a if $a.chars > $b.chars;

for 1 .. $a.chars -> $n {
    next unless $a.chars %% $n && $b.chars %% $n;

    my $c = $a.substr(0, $n);

    say $c if $c x ($a.chars / $n) eq $a && $c x ($b.chars / $n) eq $b;
}
