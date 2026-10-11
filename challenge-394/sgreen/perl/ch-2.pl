#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util qw(all min notall);

use constant VOWELS => "aeiou";

sub is_alt_vc($substr) {
    # Determine if the string is alternating between a vowel and a consonant

    # Start with the type of the fist letter
    my $vowel_next = index( VOWELS, substr( lc $substr, 0, 1 ) ) != -1 ? 1 : 0;

    foreach my $letter ( split //, lc $substr ) {
        my $letter_is_vowel = index( VOWELS, $letter ) != -1 ? 1 : 0;
        if ( $vowel_next ^ $letter_is_vowel ) {
            # The letter is the wrong type
            return 0;
        }
        # The next letter needs to be the opposite
        $vowel_next = $vowel_next ? 0 : 1;
    }
    # The word alternates between vowels and consonants
    return 1;
}

sub main (@words) {
    # Check the strings only contains letters
    if ( notall { /^[a-z]+$/i } @words ) {
        die "Some words contain non-letters\n";
    }

  # Find the shortest word (the first if there is more than one), and its length
    my $shortest_word =
      ( sort { length($a) <=> length($b) || $a cmp $b } @words )[0];
    my $min_length = length($shortest_word);

    # Try for the longest string first
    my @result = ();
    for ( my $length = $min_length ; $length > 0 ; $length-- ) {
        foreach my $start ( 0 .. $min_length - $length ) {
            my $substr = substr( $shortest_word, $start, $length );
            # The substr needs to appear in all words and correctly alternates
            #  between vowels and consonants
            if ( is_alt_vc($substr)
                and all { index( $_, $substr ) != -1 } @words )
            {
                push @result, $substr;
            }
        }

        if ( $#result != -1 ) {
            # There are valid solutions of this length, return them alphabetically
            say '("' . join( '", "', sort @result ) . '")';
            return;
        }
    }

    # No substrings found matching the criteria.
    say '()';

}

main(@ARGV);
