#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 386 Task 2: Rational Numbers
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Math::Prime::Util qw( lcm );
use List::Util qw( max );

sub rational_numbers( $rat1, $rat2 ) {
    # Split up the numbers into integer part, fixed fractional part
    # and repetend using hash keys 'i', 'f', and 'r', respectively.
    my @numbers = map {
        /^ (\d+) (?: \. (\d*) (?: \( (\d+) \) )? )? $/x;
        { i => $1, f => $2 // "", r => $3 // "0" }
    } $rat1, $rat2;

    # Define target lengths for the fixed parts and for the repetends.
    # The shorter fixed part needs to be extended to the same length as
    # the longer one's, by using digits from the repetend part,
    # to align the fixed parts.
    # For comparing the two numbers string-wise, both repetend parts
    # need to be repeated up to the least possible common length.
    my ( $target_f_length, $target_r_length ) = (
        max( map length( $_->{f} ), @numbers ),
        lcm( map length( $_->{r} ), @numbers ),
    );

    # Apply some formatting and adjusting operations to both numbers
    # so that they can be compared.
    for my $n ( @numbers ) {
        # Extend the fixed part to the target length by repeatedly appending
        # the repetend's first digit, and then 'rotating' the repetend to
        # the right. 
        # This doesn't change the number's value, only its representation.
        # Example: 12.3(45678) equals 12.34(56784)
        while ( length( $n->{f} ) < $target_f_length ) {
            my $d = substr( $n->{r}, 0, 1, "" );
            $n->{f} .= $d; $n->{r} .= $d;
        }

        # With the fixed parts having the same length, we can combine the
        # integer and the fixed part to one number, removing the decimal point.
        # This makes the following 'rounding' adjustment easier, while
        # it is not relevant for the comparison.
        $n->{f} = "$n->{i}$n->{f}";
        $n->{i} = "";

        # For a repetend of only '9's, increment the (combined) fixed part
        # by 1, and set the repetend to 0.
        if ( $n->{r} =~ /^9+$/ ) {
            $n->{f} += 1;
            $n->{r} = "0";
        }

        # Repeat the repetend to the common target length, so that in
        # the comparison, both repetends are of the same length,
        $n->{r} = $n->{r} x ( $target_r_length / length( $n->{r} ) );
    }

    # Compare the two numbers, string-wise.
    return $numbers[0]->{f} . $numbers[0]->{r}
        eq $numbers[1]->{f} . $numbers[1]->{r};
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["0.(12)", "0.(121)"], F ],
    [ "Example 2", ["0.1(23)", "0.12(32)"], T ],
    [ "Example 3", ["0.1(234)", "0.12(342)"], T ],
    [ "Example 4", ["12.99(99)", "13."], T ],
    [ "Example 5", ["0.(123)", "0.1(231)"], T ],
    [ "Own Test 1", ["12.34", "12.33(9)"], T ],
    [ "Own Test 2", ["12.34", "12.33(9)"], T ],
    [ "Own Test 3", ["12.34(0)", "12.33(9)"], T ],
    [ "Own Test 4", ["12.340(0)", "12.33(9)"], T ],
    [ "Own Test 5", ["10.", "9.(9)"], T ],
    [ "Own Test 6", ["10.00", "9.999(9)"], T ],
    [ "Own Test 7", ["12.(9)", "12.(9)"], T ],
    [ "Own Test 8", ["2.(19)", "2.1(919191)"], T ],
    [ "Own Test 9", ["5", "4.(9)"], T ],
);

is rational_numbers( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
