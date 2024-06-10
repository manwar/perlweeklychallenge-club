#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
272-1: Defang IP Address            Submitted by: Mohammad Sajid Anwar

You are given a valid IPv4 address.

Write a script to return the defanged version of the given IP address.

A defanged IP address replaces every period “.” with “[.]".

Example 1
Input: $ip = "1.1.1.1"
Output: "1[.]1[.]1[.]1"
Example 2
Input: $ip = "255.101.1.0"
Output: "255[.]101[.]1[.]0"
=end comment

my @Test =

    "1.1.1.1",             "1[.]1[.]1[.]1",
    "255.101.1.0",          "255[.]101[.]1[.]0",
;
plan @Test ÷ 2;

sub task( $a is copy) {
    $a.subst: '.', '[.]', :g;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}

done-testing;


