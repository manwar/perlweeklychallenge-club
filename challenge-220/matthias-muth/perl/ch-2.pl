#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 220 Task 2: Squareful
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( sum min max );

sub is_perfect_square {
    my $sqrt = sqrt( $_[0] );
    return int( $sqrt ) == $sqrt;
}

$| = 1;

my $indent = "";

sub squareful {
    my ( @ints ) = @_;
    vsay $indent, "squareful( @ints )";
    $indent .= "    ";

    if ( @ints == 1 ) {
        vsay $indent, "returning ( [ @ints ] )";
        substr $indent, -4, 4, "";
        return [ @ints ];
    }

    my %unique_ints = map { $_ => 1 } @ints;
    my @unique_ints = sort { $a <=> $b } keys %unique_ints;
    vsay $indent, "unique ints: ", pp @unique_ints;

    my %first_positions;
    $first_positions{ $ints[$_] } //= $_
        for 0..$#ints;
    vsay $indent, "first_positions: ", pp \%first_positions;

    my @results;
    for my $int ( @unique_ints ) {
        vsay $indent, "trying to start with $int";

        my @remaining_ints = @ints;
        splice @remaining_ints, $first_positions{$int}, 1, ();
        vsay $indent, "remaining_ints: ( @remaining_ints )";

        my @squareful_subsets = squareful( @remaining_ints );
        vsay $indent, "squareful_subsets: ", pp( @squareful_subsets );

        push @results,
            map [ $int, @{$squareful_subsets[$_]} ],
                grep {
		    my $perfect =
			is_perfect_square( $int + $squareful_subsets[$_][0] );
		    vsay $indent, "$int + $squareful_subsets[$_][0] = ",
		        $int + $squareful_subsets[$_][0], " is",
			$perfect ? " a" : " no", " perfect square";
		    $perfect
		} 0..$#squareful_subsets;
        vsay $indent, "\@results now: ", pp @results;
    }

    vsay $indent, "returning ", pp @results;
    substr $indent, -4, 4, "";
    return @results;
}

@ARGV = qw( -v );
run_tests;
