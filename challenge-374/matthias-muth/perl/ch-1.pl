#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 374 Task 1: Count Vowel
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::SomeUtils qw( minmax );

sub count_vowel( $str ) {
    # First, split the string into separate sequences of vowel only strings.
    my @vowel_strings = split " ", ( lc $str ) =~ s/[^aeiou]/ /gr;

    my @results;
    # For each of the vowel strings, find the correct vowel substrings.
    for my $vowel_string ( @vowel_strings ) {
        # Separate the vowel string into an array of characters.
        my @a = split "", $vowel_string;
        # For each vowel, create an ordered list of all its positions in the
        # string.
        my %positions;
        push $positions{ $a[$_] }->@*, $_
            for keys @a;
        # Now we move from left to right.
        # As long as we still have available positions for all five vowels,
        # there are valid substrings.
        while ( %positions == 5 ) {
            # All valid substring starting at the current position have to
            # include all vowels, in particular the vowel that is furthest away.
            # We then can also include all substrings that are longer than that,
            # up to the end of the complete string.
            my ( $first, $last ) = minmax( map $_->[0], values %positions );
            push @results,
                map { join "", @a[$first..$_] } $last .. $#a;
            # Remove the current position, for the next iteration to start
            # with the next one.
            shift $positions{ $a[$first] }->@*;
            # If this was the last available position for this vowel,
            # we are done with this vowel string.
            last if $positions{ $a[$first] }->@* == 0;
        }
    }
    return @results;
}

use lib qw( . ../../../lib );
use MultiTest;

my @tests = (
    [ "Example 1", "aeiou", ["aeiou"] ],
    [ "Example 2", "aaeeeiioouu",
        bag {
            item $_ for "aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu";
            end;
        }
    ],
    [ "Example 3", "aeiouuaxaeiou",
        bag {
            item $_ for "aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua";
            end;
        }
    ],
    [ "Example 4", "uaeiou",
        bag { item $_ for "aeiou", "uaeio", "uaeiou"; end } ],
    [ "Example 5", "aeioaeioa", [] ],
);

run( "count_vowel", \@tests );

__END__

# Version for publishing:

use Test2::V0 qw( -no_srand );
is [ count_vowel( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;
done_testing;
