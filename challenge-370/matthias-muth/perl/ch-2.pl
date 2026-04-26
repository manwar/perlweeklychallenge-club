#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 370 Task 2: Scramble String
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( indexed true false );

use List::Util qw( any );

# sub scrambles( $str )
# Returns all possible scrambles for a string.
# Implemented for testing the 'is_reverse_scramble' subroutine.
sub scrambles( $str ) {
    return $str
        if length( $str ) == 1;
    my %results;
    for ( 1 .. length( $str ) - 1 ) {
        my @part1_scrambles = scrambles( substr( $str, 0, $_ ) );
        my @part2_scrambles = scrambles( substr( $str, $_ ) );
        for my $a ( @part1_scrambles ) {
            for my $b ( @part2_scrambles ) {
                ++$results{"$a$b"};
                ++$results{"$b$a"};
            }
        }
    }
    return keys %results;
}

# Challenge task solution v1.0 (brute force):
sub is_scramble( $str1, $str2 ) {
    return any { $_ eq $str2 } scrambles( $str1 );
}

# Challenge task solution v2.0 ('Reverse Scramble'):
sub is_reverse_scramble( $str1, $str2 ) {

    # Convert the strings into sequences of index numbers,
    # taking care of assigning different numbers to duplicate
    # characters.
    my %indexes;
    for my ( $index, $letter ) ( indexed split "", $str1 ) {
        push $indexes{$letter}->@*, $index;
    }

    # Create single number streaks.
    my @streaks =
        map [ shift $indexes{$_}->@* // return false ],
            split "", $str2;

    # Repetitively combine adjacent streaks if they form a contiguous
    # new streak.
    while ( @streaks > 1 ) {
        # Use a separate array for building the combined streaks,
        # because manipulating the @streaks array within the loop
        # is too dangerous.
        my @new_streaks = ( $streaks[0] );
        my $could_combine = false;
        for ( @streaks[ 1 .. $#streaks ] ) {
            if ( $_->[0] == $new_streaks[-1][-1] + 1 ) {
                # Combine in current order.
                $could_combine = true;
                push $new_streaks[-1]->@*, $_->@*;
            }
            elsif ( $new_streaks[-1][0] == $_->[-1] + 1 )
            {
                # Combine in exchanged order.
                $could_combine = true;
                unshift $new_streaks[-1]->@*, $_->@*;
            }
            else {
                # No combination.
                push @new_streaks, $_;
            }
        }
        # No combinations were possible. Return failure.
        return false
            if ! $could_combine;

        # Prepare the next iteration.
        @streaks = @new_streaks;
    }
    return true;
}

use Test2::V0 qw( -no_srand );

sub run_challenge_tests() {
    is is_scramble( "abc", "acb" ), T,
        'Example 1: is_scramble( "abc", "acb" ) is true';
    is is_scramble( "abcd", "cdba" ), T,
        'Example 2: is_scramble( "abcd", "cdba" ) is true';
    is is_scramble( "hello", "hiiii" ), F,
        'Example 3: is_scramble( "hello", "hiiii" ) is false';
    is is_scramble( "ateer", "eater" ), T,
        'Example 4: is_scramble( "ateer", "eater" ) is true';
    is is_scramble( "abcd", "bdac" ), F,
        'Example 5: is_scramble( "abcd", "bdac" ) is false';

    is is_reverse_scramble( "abc", "acb" ), T,
        'Example 1: is_reverse_scramble( "abc", "acb" ) is true';
    is is_reverse_scramble( "abcd", "cdba" ), T,
        'Example 2: is_reverse_scramble( "abcd", "cdba" ) is true';
    is is_reverse_scramble( "hello", "hiiii" ), F,
        'Example 3: is_reverse_scramble( "hello", "hiiii" ) is false';
    is is_reverse_scramble( "ateer", "eater" ), T,
        'Example 4: is_reverse_scramble( "ateer", "eater" ) is true';
    is is_reverse_scramble( "abcd", "bdac" ), F,
        'Example 5: is_reverse_scramble( "abcd", "bdac" ) is false';

    done_testing;
}

unless ( caller ) {
    run_challenge_tests;
}
