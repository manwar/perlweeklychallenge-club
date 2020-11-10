#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use List::Util qw(sum);

sub main {
    my @numbers = @_;

    # Check that all numbers are positive
    die "You must specify at least three numbers\n" if scalar(@numbers) < 3;
    foreach my $x (@numbers) {
        die "The value '$x' is not a positive number"
          unless $x =~ /^[0-9]+(?:\.[0-9]+)$/ and $x > 0;
    }

    # Remove any number that is >= 2, as they can't make the solution
    @numbers = grep { $_ < 2 } @numbers;

    for my $x ( 7 .. 2**scalar(@numbers) - 1 ) {
        my @bits = split( //, sprintf( '%0b', $x ) );

        # Only proceed if we have three bits set
        next if sum(@bits) != 3;

        # Get the sum of the three choosen digits
        my @num = map { $numbers[$_] } grep { $bits[$_] } ( 0 .. $#numbers );
        my $sum = sum(@num);

        # If the 1 < sum < 2, then display the result and exit
        if ( $sum > 1 and $sum < 2 ) {
            say 'Output: 1 as 1 < ', join( ' + ', @num ), ' < 2';
            return;
        }
    }

    say 'Output: 0';
}

main(@ARGV);
