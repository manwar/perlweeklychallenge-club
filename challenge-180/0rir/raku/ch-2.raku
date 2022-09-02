#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;

constant TEST=False;

=begin comment
Task 2: Trim List       Submitted by: Mohammad S Anwar
Given a list of numbers, @n and an integer $i, trim the list where
element is less than or equal to the given integer.

NOTE: The 1st example conflicts with the specification given; the second
doesn't clarify.  Precedence is given to the specs.

Example 1
Input: @n = (1,4,2,3,5) and $i = 3
Output: (4,3,5)
Example 2
Input: @n = (9,0,6,2,3,8,5) and $i = 4
Output: (9,6,8,5)
=end comment

sub gt-grep( Int $limit, List $bucket) {
    $bucket.grep: { $_ > $limit};
}

if TEST {
    my @Test =
    { in => ( 5,  ( 5,)) , exp => () },
    { in => ( 3,  (1, 4, 2, 3, 5)), exp => ( 4, 5) },
    { in => ( 4,  (9, 0, 6, 2, 3, 8, 5)) , exp => ( 9, 6, 8, 5) }, ;

    plan @Test.elems;
    for @Test -> %t {
        is gt-grep( %t<in>[0], %t<in>[1]), %t<exp>, "%t<in>";
    }
    done-testing;
    exit;
}

sub MAIN( $i = 5, @n = (1,9,0,6,2,3,8,5,104,) ) {
    say 'Input: @n = (', @n.join(','), ') and $i = ',$i ;
    say 'Output: (', gt-grep( $i, @n).join(','), ')';
}

