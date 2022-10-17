#!/usr/bin/env raku

=begin pod

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #2: Magical Triplets

    You are given a list of positive numbers, C<@n>, having at least 3 numbers.

    Write a script to find the triplets C<(a, b, c)> from the given list that
    satisfies the following rules.

    1. a + b > c
    2. b + c > a
    3. a + c > b
    4. a + b + c is maximum.

    In case, you end up with more than one triplets having the maximum then
    pick the triplet where a >= b >= c.

=end pod

use Test;

is <3 2 2>, magical-triplets <1 2 3 2>;
is Nil,     magical-triplets <1 3 2>;
is Nil,     magical-triplets <1 1 2 3>;
is <4 3 2>, magical-triplets <4 3 2>;

done-testing;

sub magical-triplets(@n) {
  my @triplets = @n.combinations(3).map( { |.permutations } ).
    grep({ .[0] + .[1] > .[2] && .[1] + .[2] > .[0] && .[0] + .[2] > .[1] }).
    sort({ not( .[0] ≥ .[1] ≥ .[2] ) });
  @triplets.map({ [+] $_ }).maxpairs.map({ @triplets[.key] }).head
}

