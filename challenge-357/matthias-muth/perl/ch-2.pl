#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 357 Task 2: Unique Fraction Generator
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Math::Utils qw( gcd );

sub unique_fraction_generator( $int ) {
    my %values;
    for my $num ( 1..$int ) {
        for my $denum ( 1..$int ) {
            my $gcd = gcd( $num, $denum );
            $values{ ( $num / $gcd ) . "/" . ( $denum / $gcd ) } =
                $num / $denum;
        }
    }
    return sort { $values{$a} <=> $values{$b} } keys %values;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", 3, [ qw( 1/3 1/2 2/3 1/1 3/2 2/1 3/1 ) ] ],
    [ "Example 2", 4, [ qw( 1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1 ) ] ],
    [ "Example 3", 1, [ qw( 1/1 ) ] ],
    [ "Example 4", 6, [ qw( 1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 5/6 1/1
                            6/5 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1 6/1 ) ] ],
    [ "Example 5", 5, [ qw( 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1
                            5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1 ) ] ],
);

for ( @tests ) {
    my ( $test, $input, $expected ) = $_->@*;
    is [ unique_fraction_generator( $input ) ], $expected,
        "$test: unique_fraction_generator( $input ) => ( $expected->@* )";
}

done_testing;
