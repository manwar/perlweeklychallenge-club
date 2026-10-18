#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'uniq';

sub find_word_squares( $words, $words_so_far ) {
    if ( not defined $words_so_far ) {
        # First call
        $words_so_far = [];
    }

    my $length = length( $words->[0] );
    if ( scalar(@$words_so_far) == $length ) {
        # We have found a valid list, return upstream
        return $words_so_far;
    }

   # Calculate the position we need to find next, and the letters it starts with
    my $this_pos     = scalar(@$words_so_far);
    my %words_so_far = ();
    @words_so_far{@$words_so_far} = ();

    my $starts_with =
      join( "", map { substr( $_, $this_pos, 1 ) } @$words_so_far );
    my @possible_next_words = grep {
        substr( $_, 0, $this_pos ) eq $starts_with
          and not exists( $words_so_far{$_} )
    } @$words;

    # Loop through possible next words, calling the function again
    foreach my $word (@possible_next_words) {
        my $result = find_word_squares( $words, [ @$words_so_far, $word ] );
        if ( defined $result ) {
            # We have found a valid list, return upstream
            return $result;
        }
    }

    # No combination is found.
    return undef;
}

sub main (@words) {
    # Check all words are the same length
    if ( scalar( uniq( map { length($_) } @words ) ) != 1 ) {
        die "All words must be the same length\n";
    }

    # Call a recursive function to find the correct word order
    my $result = find_word_squares( \@words, [] );
    say '("' . join( '", "', @$result ) . '")';
}

main(@ARGV);
