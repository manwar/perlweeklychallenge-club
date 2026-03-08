#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature qw(say unicode_strings);
use experimental 'signatures';

sub main ($input_string) {
    my %word2num = (
        qw/
          zero 0 one 1 two 2 three 3 four 4 five 5 six 6 seven 7 eight 8
          nine 9 ten 10 eleven 11 twelve 12 thirteen 13 fourteen 14
          fifteen 15 sixteen 16 seventeen 17 eighteen 18 nineteen 19 twenty 20
          /
    );

    my ( $word, $v, $c ) =
      ( $input_string =~ /(\w+) . (\w+) vowels? and (\w+) consonants?/ );

    if ( !$word ) {
        die "Input string not in expected format\n";
    }

    # Count the number of vowels and consonants in the first word
    my $vowel_count = 0;
    my $const_count = 0;
    foreach my $c ( split //, lc($word) ) {
        if ( index( "aeiou", $c ) == -1 ) {
            $const_count++;
        }
        else {
            $vowel_count++;
        }
    }

    # Convert the words in the string into integers
    my $expected_vowel = $word2num{ lc $v } // die "Don't know what $v is\n";
    my $expected_const = $word2num{ lc $c } // die "Don't know what $c is\n";

    # Return if the statement is true
    my $truth =
      ( $vowel_count == $expected_vowel and $const_count == $expected_const );
    say $truth ? 'true' : 'false';
}

main(@ARGV);
