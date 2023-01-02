#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

constant @prior-prime = gather for 0..∞ -> $i {
    state $current = 0;
    take $current;
    ++$current if $i.is-prime;
}

=begin comment
198 2: Prime Count          Submitted by: Mohammad S Anwar
Given an integer $n > 0, print the count of primes less than $n.

Example 1
Input: $n = 10
Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.

=end comment

sub MAIN () {
    my @Test =
        { in =>  10,  exp => 4, },
        { in =>  15,  exp => 6, },
        { in =>   1,  exp => 0, },
        { in =>  25,  exp => 9, },
    ;
    plan +@Test;
    for @Test -> %t {
        is @prior-prime[%t<in>], %t<exp>,  "%t<in> -> %t<exp>";
    }
    done-testing;

    say "\nInput: \$n = ", my $n = 100, "\nOutput: @prior-prime[$n]";
}
