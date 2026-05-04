#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 371 Task 1: Missing Letter
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub missing_letter( @seq ) {
    my @nums = map ord, @seq;
    my $qm_index = ( grep $seq[$_] eq "?", keys @seq )[0];
    my @hardcoded_indices = (
        [ 1, 2, 3 ],
        [ 0, 3, 2 ],
        [ 3, 0, 1 ],
    );
    my ( $base, $add, $subtract ) =
        map { $nums[$_] }
            exists $hardcoded_indices[$qm_index]
            ? $hardcoded_indices[$qm_index]->@*
            : map { $qm_index + $_ } ( -1, -2, -3 );
    return chr( $base + $add - $subtract );
}

use Test2::V0 qw( -no_srand );

is missing_letter( qw(a c ? g i) ), "e",
    'Example 1: missing_letter( qw(a c ? g i) ) eq "e"';
is missing_letter( qw(a d ? j m) ), "g",
    'Example 2: missing_letter( qw(a d ? j m) ) eq "g"';
is missing_letter( qw(a e ? m q) ), "i",
    'Example 3: missing_letter( qw(a e ? m q) ) eq "i"';
is missing_letter( qw(a c f ? k) ), "h",
    'Example 4: missing_letter( qw(a c f ? k) ) eq "h"';
is missing_letter( qw(b e g ? l) ), "j",
    'Example 5: missing_letter( qw(b e g ? l) ) eq "j"';

is missing_letter( qw(? b c d) ), "a",
    'Own Test 1: missing_letter( qw(? b c d) ) eq "a"';
is missing_letter( qw(a ? c d) ), "b",
    'Own Test 1: missing_letter( qw(a ? c d) ) eq "b"';
is missing_letter( qw(a b ? d) ), "c",
    'Own Test 1: missing_letter( qw(a b ? d) ) eq "c"';
is missing_letter( qw(a b c ?) ), "d",
    'Own Test 1: missing_letter( qw(a b c ?) ) eq "d"';

done_testing;
