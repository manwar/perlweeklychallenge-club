#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 372 Task 1: Rearrange Spaces
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub rearrange_spaces( $str ) {
    my @words = split " ", $str;
    my $n_gaps = scalar @words - 1;
    my $n_spaces = $str =~ tr/ //;
    my $gap_length = $n_gaps > 0 ? int( $n_spaces / $n_gaps ) : 0;
    my $n_trailing = $n_spaces - $n_gaps * $gap_length;
    return join( " " x $gap_length, @words ) . " " x $n_trailing;
}

use Test2::V0 qw( -no_srand );

is rearrange_spaces( "  challenge  " ), "challenge    ",
    'Example 1: rearrange_spaces( "  challenge  " ) eq "challenge    "';
is rearrange_spaces( "coding  is  fun" ), "coding  is  fun",
    'Example 2: rearrange_spaces( "coding  is  fun" ) eq "coding  is  fun"';
is rearrange_spaces( "a b c  d" ), "a b c d ",
    'Example 3: rearrange_spaces( "a b c  d" ) eq "a b c d "';
is rearrange_spaces( "  team      pwc  " ), "team          pwc",
    'Example 4: rearrange_spaces( "  team      pwc  " ) eq "team          pwc"';
is rearrange_spaces( "   the  weekly  challenge  " ),
    "the    weekly    challenge ",
    'Example 5: rearrange_spaces( "   the  weekly  challenge  " )'
        . ' eq "the    weekly    challenge "';

done_testing;
