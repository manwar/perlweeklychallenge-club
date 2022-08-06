#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 2: Reversible Numbers  Submitted by: Mohammad S Anwar

Find  all Reversible Numbers below 100.

An integer is reversible if the sum of the number and its
textual reverse has only odd digits.  Single digit
integers are deemed not reversible.

36 is reversible as 36 + 63 = 99 i.e. all digits are odd.
17 is not reversible as 17 + 71 = 88, not all are odd.

=end comment

constant @exp =
    10, 12, 14, 16, 18, 21, 23, 25, 27,
    30, 32, 34, 36, 41, 43, 45, 50, 52,
    54, 61, 63, 70, 72, 81, 90;

sub reversible( $c --> Bool ) {
    return False if $c < 10;
    $_ = $c;
    $_ += .flip;
    ? m{ ^ <[13579]>+ $ };
}

my @ary = gather for 1..99 { .&take if reversible($_) }

constant TEST = False;
if TEST {
    plan 1;
    is @ary, @exp, 'Scan of 1 - 99';
    done-testing;
    exit;
}

sub MAIN( ) {
    say "Output\n",  @ary.join( ', ');
}
