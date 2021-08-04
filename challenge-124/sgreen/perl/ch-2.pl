#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(none sum);

sub _get_next_combination {
    my ( $size, @combination ) = @_;

    # First time run
    if ( scalar(@combination) == 0 ) {
        my $half_size = int( $size / 2 );
        return ( 0 .. $half_size - 1 );
    }

    # How many numbers do we need to change
    my $count = 0;
    while ( ++$count ) {
        last if $combination[ -$count ] < $size - $count;

        # There are no more combinations
        return if $count == int( $size / 2 );
    }

    # Add one to the first number
    $combination[ -$count ]++;

    # If there is any other numbers to change, add 1 from the previous digit
    foreach my $i ( $#combination - $count + 2 .. $#combination ) {
        $combination[$i] = $combination[ $i - 1 ] + 1;
    }

    return @combination;
}

sub main {
    my @values = @_;
    my $size   = @values;

    # Sanity check
    die "You must provide two or more integers\n" unless $size > 1;
    foreach my $x (@values) {
        die "The value '$x does not appear to be a integer\n" unless $x =~ /^-?[0-9]+$/;
    }

    # Get half the sum of all the numbers. This is the target we want to
    #  hit for one of the sets.
    my $target = sum(@values) / 2;

    # This records the best set we've found so far.
    my $best_sum    = 'inf';
    my @first_set   = ();
    my @combination = ();

    # Go through all possible combinations of the first set
    while ( @combination = _get_next_combination( $size, @combination ) ) {

        # Calculate the difference between the sum of this set and the target
        my $sum  = sum( @values[@combination] );
        my $diff = abs( $sum - $target );

        if ( $diff == 0 ) {
            # We've find the best combination
            @first_set = @combination;
            last;
        }
        elsif ( $diff < $best_sum ) {
            # We've found a better combination
            $best_sum  = $diff;
            @first_set = @combination;
        }

    }

    # Get the second set (everything not in the first set!)
    my @second_set = grep {
        my $i = $_;
        none { $i == $_ } @first_set
    } ( 0 .. $#values );

    # Print the results
    say 'Subset 1 = (', join( ', ', @values[@first_set] ),  ')';
    say 'Subset 2 = (', join( ', ', @values[@second_set] ), ')';

}

main(@ARGV);
