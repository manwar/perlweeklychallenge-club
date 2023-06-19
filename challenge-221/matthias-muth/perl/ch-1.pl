#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 221 Task 1: Good Strings
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

sub good_strings {
    my ( $words, $chars ) = @_;

    my $ordered_chars = join "", sort split '', $chars;
    say "ordered chars: $ordered_chars";

    my $result = 0;
    for my $word ( @$words ) {
        my $pattern = '^.*' . join( '.*', sort split '', $word ) . '.*$';
	say "pattern for '$word': qr/$pattern/";
	$result += length( $word )
	    if $ordered_chars =~ /${pattern}/;
    }
    return $result;
}

run_tests;
