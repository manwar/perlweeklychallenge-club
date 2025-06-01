#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'min';

sub main (@numbers) {
    # Check we have an odd number of arguments
    die "Please provide an odd number of arguments" if @numbers % 2 == 0;

    my $income       = shift(@numbers);
    my @tax_brackets = ();
    while ( scalar(@numbers) ) {
        push @tax_brackets, [ shift(@numbers), shift(@numbers) ];
    }

    # Check income does not exceed the last tax bracket
    if ( $income > $tax_brackets[-1][0] ) {
        die "Income exceeds the last tax bracket limit.\n";
    }

    # Add a zero tax bracket
    unshift( @tax_brackets, [ 0, 0 ] );

    # Initialize total tax amount
    my $total_tax = 0;

    # Iterate through tax brackets
    foreach my $idx ( 1 .. $#tax_brackets ) {
        my ( $tax_threshold, $tax_rate ) = @{ $tax_brackets[$idx] };
        $total_tax +=
          ( min( $income, $tax_threshold ) - $tax_brackets[ $idx - 1 ][0] ) *
          ( $tax_rate / 100 );

        # We don't need to look at further brackets if income is less than
        #  or equal to the current threshold
        if ( $income <= $tax_threshold ) {
            last;
        }
    }

    say sprintf '%0.2f', $total_tax;
}

main(@ARGV);
