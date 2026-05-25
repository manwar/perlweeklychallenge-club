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
use List::Util qw( max );

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
        # If we have available positions for all five vowels,
        # there is at least one valid substring.
        next if %positions < 5;
        # Starting from the beginning of the string, we can use all positions
        # as starting positions, as long as all five vowels are still
        # available.
        for my $start_pos ( keys @a ) {
            # A valid substring has to include all vowels.
            # If it includes the first occurrence of the vowel that is furthest
            # away, it will automatically include all the others.
            # That means that all valid substrings have to include at least that
            # position. They also can be longer than that, up to the end of the
            # complete string.
            my $first_end_pos = max( map $_->[0], values %positions );
            push @results,
                map { join "", @a[ $start_pos .. $_ ] } $first_end_pos .. $#a;
            # Remove the current vowel's position now that it was used.
            shift $positions{ $a[$start_pos] }->@*;
            # If this was the last available position for this vowel, there
            # cannot be any more valid substrings within this vowel string,
            # and we can shortcut the loop.
            last if $positions{ $a[$start_pos] }->@* == 0;
        }
    }
    return @results;
}

use Test2::V0 qw( -no_srand );

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

is [ count_vowel( $_->[1] ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
