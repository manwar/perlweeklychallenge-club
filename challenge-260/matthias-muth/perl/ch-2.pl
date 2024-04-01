#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 260 Task 2: Dictionary Rank
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Data::Dump qw( pp );

sub combinations( %freq ) {
    return keys %freq
	if %freq == 1 && ( values %freq )[0] == 1;
    my @combinations;
    for my $letter ( sort keys %freq ) {
	delete $freq{$letter}
	    if --$freq{$letter} == 0;
	push @combinations, map $letter . $_, combinations( %freq );
	++$freq{$letter};
    }
    return @combinations;
}

sub dictionary_rank( $word ) {
    my %freq;
    ++$freq{$_}
	for split "", $word;
    my @combinations = combinations( %freq );
    for ( 0..$#combinations ) {
	return 1 + $_
	    if $combinations[$_] eq $word;
    }
}

use Test2::V0 qw( -no_srand );

is [ combinations( A => 1 ) ], [ "A" ], "Single letter A";
is [ combinations( A => 2 ) ], [ "AA" ], "Double letter A";
is [ combinations( A => 1, B => 1 ) ], [ qw( AB BA ) ], "A B";
is [ combinations( C => 1, A => 1, T => 1 ) ],
    [ qw( ACT ATC CAT CTA TAC TCA ) ], "CAT";

is dictionary_rank( "CAT" ), 3,
    'Example 1: dictionary_rank( "CAT" ) == 3';
is dictionary_rank( "GOOGLE" ), 88,
    'Example 2: dictionary_rank( "GOOGLE" ) == 88';
is dictionary_rank( "SECRET" ), 255,
    'Example 3: dictionary_rank( "SECRET" ) == 255';
done_testing;
