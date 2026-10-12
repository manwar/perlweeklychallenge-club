#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 394 Task 2: Alternating Vowels Consonants
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( all );

sub alternating_vowels_consonants( @str ) {
    # Extract all alternating sequences from the first string.
    # Alternating sequences might start with a vowel or a consonant,
    # so the regex has to check for both. 
    my ( $v, $c ) = ( qr/[aeiou]/, qr/[^aeiou]/ );
    my @alt_strings =
        $str[0] =~ / (?: $v $c )+ $v? | (?: $c $v )+ $c? /xg;

    # Now that we have all alternating sequences from the first word,
    # we need to check all possible substrings for matches in the other
    # input words.
    # We try the longest strings first, because we might save a lot of
    # iterations over shorter substrings once we get a hit.
    my $min_len = 2;
    my @results = ();
    for ( sort { length( $b ) <=> length( $a ) } @alt_strings ) {
        for ( my $len = length( $_ ); $len >= $min_len; --$len ) {
            for my $pos ( 0 .. length( $_ ) - $len ) {
                my $substring = substr( $_, $pos, $len );
                if ( all { /$substring/ } @str[1..$#str] ) {
                    if ( $len > $min_len ) {
                        $min_len = $len;
                        @results = ();
                    }
                    push @results, $substring;
                }
            }
        }
    }

    return @results;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["relocate", "delocate", "allocate"], ["locate"] ],
    [ "Example 2", ["apple", "banana", "cherry"], [] ],
    [ "Example 3", ["navigate", "cavity", "gravity"], ["avi"] ],
    [ "Example 4", ["pedalgia", "pedalboard", "pedantic"], ["peda"] ],
    [ "Example 5", ["schoolmaster", "schoolhouse", "schooling"], ["ho", "ol"] ],
);

is [ alternating_vowels_consonants( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
