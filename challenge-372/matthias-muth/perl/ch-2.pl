#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 372 Task 2: Largest Substring
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin 'indexed';                # Not needed with 'use v5.40' or higher.

no warnings 'experimental::builtin';  # Not needed running Perl version >= 5.40.
no warnings 'experimental::for_list'; # Not needed running Perl version >= 5.40.

sub largest_substring( $str ) {
    my ( $max_length, %seq_start ) = ( -1 );
    for my ( $index, $char ) ( indexed split "", $str ) {
        if ( ! exists $seq_start{$char} ) {
            $seq_start{$char} = $index + 1;
            next;
        }
        my $length = $index - $seq_start{$char};
        $max_length = $length
            if $length > $max_length;
    }
    return $max_length;
}

sub largest_substring( $str ) {
    my ( $max_length, %seq_start ) = ( -1 );
    for my ( $index, $char ) ( indexed split "", $str ) {
        $seq_start{$char} //= $index + 1;
        my $length = $index - $seq_start{$char};
        $length < $max_length or $max_length = $length;
    }
    return $max_length;
}

use List::Util qw( max );
sub largest_substring( $str ) {
    my %seq_start;
    return max(
        map $_ - ( $seq_start{ substr( $str, $_, 1 ) } //= $_ + 1 ),
            0 .. length( $str ) - 1
    ) // -1;
}

use Test2::V0 qw( -no_srand );

is largest_substring( "aaaaa" ), 3,
    'Example 1: largest_substring( "aaaaa" ) == 3';
is largest_substring( "abcdeba" ), 5,
    'Example 2: largest_substring( "abcdeba" ) == 5';
is largest_substring( "abbc" ), 0,
    'Example 3: largest_substring( "abbc" ) == 0';
is largest_substring( "abcaacbc" ), 4,
    'Example 4: largest_substring( "abcaacbc" ) == 4';
is largest_substring( "laptop" ), 2,
    'Example 5: largest_substring( "laptop" ) == 2';

is largest_substring( "laptop" ), 2,
    'Own Test 1: largest_substring( "abc" ) == -1';
is largest_substring( "laptop" ), 2,
    'Own Test 2: largest_substring( "" ) == -1';

done_testing;
