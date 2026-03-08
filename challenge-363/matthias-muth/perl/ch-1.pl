#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 363 Task 1: String Lie Detector
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

use Lingua::EN::Words2Nums;

sub string_lie_detector( $str ) {
    # Separate the statement from the string, using any
    # non-whitespace, non-word character (typically a '-') as the separator.
    # Remove whitespace around that separator while we're at it.
    ( $str, my $statement ) = split /\s*+[^\s\w]\s*+/, $str, 2;

    # Sum up the respective numbers mentioned.
    my ( $expected_vowels, $expected_consonants ) = ( 0, 0 );
    $expected_vowels +=
        words2nums( $1 ) // ( $1 =~ /^no$/i ? 0 : return false )
        while $statement =~ /(\w+)\s+vowels?/ig;
    $expected_consonants +=
        words2nums( $1 ) // ( $1 =~ /^no$/i ? 0 : return false )
        while $statement =~ /(\w+)\s+consonants?/ig;

    # Count the actual numbers of vowels and consonants.
    my $vowels     = () = $str =~ /([aeiou])/ig;
    my $consonants = () = $str =~ /(?=[a-z])([^aeiou])/ig;

    return $vowels == $expected_vowels && $consonants == $expected_consonants;
}

use Test2::V0 qw( -no_srand );

is string_lie_detector( "aia - three vowels" ), T,
    'Own Test 2: Vowels only';
is string_lie_detector( "xyz - three consonants" ), T,
    'Own Test 3: Consonants only';
is string_lie_detector( "bca - two consonants and one vowel" ), T,
    'Own Test 1: Reversed claims';
is string_lie_detector( "abcio - one vowel, two consonants, two vowels" ), T,
    'Own Test 4: Add up multiple mentions';
is string_lie_detector( "abc - one vowel - two consonants" ), T,
    "Own Test 5: Make sure 'split' works correctly";
is string_lie_detector( "bc - no vowels - two consonants" ), T,
    "Own Test 6: Understand 'no vowels'";

is string_lie_detector( "aa \x{2014} two vowels and zero consonants" ), T,
    'Example 1: string_lie_detector( "aa \x{2014} two vowels and zero consonants" ) is true';
is string_lie_detector( "iv \x{2014} one vowel and one consonant" ), T,
    'Example 2: string_lie_detector( "iv \x{2014} one vowel and one consonant" ) is true';
is string_lie_detector( "hello - three vowels and two consonants" ), F,
    'Example 3: string_lie_detector( "hello - three vowels and two consonants" ) is false';
is string_lie_detector( "aeiou \x{2014} five vowels and zero consonants" ), T,
    'Example 4: string_lie_detector( "aeiou \x{2014} five vowels and zero consonants" ) is true';
is string_lie_detector( "aei \x{2014} three vowels and zero consonants" ), T,
    'Example 5: string_lie_detector( "aei \x{2014} three vowels and zero consonants" ) is true';

done_testing;
