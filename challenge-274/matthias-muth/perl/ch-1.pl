#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 274 Task 1: Goat Latin
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub goat_latin_1( $sentence ) {
    my @results;
    my $maa = "maa";
    for ( split " ", $sentence ) {
	/^(?: (?<vowel>[aeiou]) | (?<cons>\w) ) (?<rest>.*)/xi;
	push @results, ( $+{cons} ? "$+{rest}$+{cons}" : $_ ) . $maa;
	$maa .= "a";
    }
    return join " ", @results;
}

sub goat_latin( $sentence ) {
    my $suffix = "ma";
    return join " ",
        map {
            /^ (?: ([aeiou]) | (\w) ) (.*) /xi;
            $suffix .= "a";
            ( $1 ? $_ : "$3$2" ) . $suffix;
        } split " ", $sentence;
}

use Test2::V0 qw( -no_srand );
is goat_latin( "I love Perl" ), "Imaa ovelmaaa erlPmaaaa",
    'Example 1: goat_latin( "I love Perl" ) == "Imaa ovelmaaa erlPmaaaa"';
is goat_latin( "Perl and Raku are friends" ), "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa",
    'Example 2: goat_latin( "Perl and Raku are friends" ) == "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"';
is goat_latin( "The Weekly Challenge" ), "heTmaa eeklyWmaaa hallengeCmaaaa",
    'Example 3: goat_latin( "The Weekly Challenge" ) == "heTmaa eeklyWmaaa hallengeCmaaaa"';
done_testing;
