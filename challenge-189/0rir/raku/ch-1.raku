#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
189-1: Greater Character       Submitted by: Mohammad S Anwar

You are given an array of characters (a..z) and a target character.
Find the smallest character in the given array lexicographically
greater than the target character.

Example 1
Input: @array = qw/e m u g/, $target = 'b'
Output: e
Example 2
Input: @array = qw/d c e f/, $target = 'a'
Output: c
Example 3
Input: @array = qw/j a r/, $target = 'o'
Output: r
Example 4
Input: @array = qw/d c a f/, $target = 'a'
Output: c
Example 5
Input: @array = qw/t g a l/, $target = 'v'
Output: v
=end comment

my @Test;

sub next-gt( Str $ch, List $char ) {
    my $r = (@$char.grep( * gt $ch )).min( :by( &infix:<~~> ));
    $r ~~ ∞ ?? $ch !! $r;
}

sub MAIN (  ) {

my @Test =
    { array => qw/e m u g/, target => 'b', exp => 'e',},
    { array => qw/d c e f/, target => 'a', exp => 'c',},
    { array => qw/j a r/,   target => 'o', exp => 'r',},
    { array => qw/d c a f/, target => 'a', exp => 'c',},
    { array => qw/t g a l/, target => 'v', exp => 'v',},
    { array => qw//, target => 'v', exp => 'v',},
    ;

    plan +@Test;
    for @Test -> %t {
        is next-gt( %t<target>, @(%t<array>)), %t<exp>,
                "%t<target> @(%t<array>).raku() ->  %t<exp>";
    }
    done-testing;
    exit;
}

