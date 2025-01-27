#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 305 Task 2: Alien Dictionary
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Dsay;

use List::Util qw( max );

sub compare_ranks( $a, $b, $character_ranks ) {
    # Compare the two strings character by character, by their
    # respective ranks.
    # When all previous characters compared equal, and the shorter of
    # the two strings runs out of characters, the rank comparison of
    # the resulting empty string will cause the loop to exit.
    for ( 0 .. ( max( length( $a ), length( $b ) ) - 1 ) ) {
	my ( $rank_a, $rank_b ) = (
	    $character_ranks->{ substr( $a, $_, 1 ) },
	    $character_ranks->{ substr( $b, $_, 1 ) },
	);

	# Continue comparing if the character ranks are the same.
	next if $rank_a == $rank_b;

	# If they are different, we have a decision.
	return $rank_a <=> $rank_b;
    }

    # On loop exit, we have compared all characters, and all are equal.
    return 0;
}

sub alien_dictionary( $words, $alien ) {

    # Create a lookup table for each character's rank.
    # The alphabet's first character has rank 1.
    # Rank 0 is reserved for the empty string, because it should sort
    # before any other character.
    my %alien_ranks = map { $alien->[$_] => $_ + 1 } keys $alien->@*;
    $alien_ranks{""} = 0;

    return sort { compare_ranks( $a, $b, \%alien_ranks ) } $words->@*;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ alien_dictionary( ["perl", "python", "raku"],
	[ qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/ ] ) ],
    [ "raku", "python", "perl" ],
    "Example 1:\n"
    . "    alien_dictionary( [ \"perl\", \"python\", \"raku\" ],\n"
    . "        [ qw/ h l a b y d e f g i r k m n o p q j s t u v w x c z / ]\n"
    . "    ) == ( \"raku\", \"python\", \"perl\" )";
is [ alien_dictionary( [ "the", "weekly", "challenge" ],
	[ qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/ ] ) ],
    [ "challenge", "the", "weekly" ],
    "Example 2:\n"
    . "    alien_dictionary( [ \"the\", \"weekly\", \"challenge\" ],\n"
    . "        [ qw/c o r l d a b t e f g h i j k m n p q s w u v x y z / ]\n"
    . "    ) == ( \"challenge\", \"the\", \"weekly\" )";

done_testing;
