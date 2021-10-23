#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _is_sedol {
    my $input  = shift;
    my @weight = qw(1 3 1 7 3 9 1);

    # Check that valid characters are used. The first six
    #  characters are letters (not vowels) or numbers. The last
    #  character must be a digit.
    return 0 unless $input =~ /^[B-DF-HJ-NP-TV-Z0-9]{6}[0-9]$/;

    # Start with the last digit
    my $sum = substr( $input, 6 );
    for my $i ( 0 .. 5 ) {
        # Get the character, and work out its value.
        my $c = substr( $input, $i, 1 );
        my $v = $c =~ /[0-9]/ ? $c : ord($c) - 55;

        # Add the value to the sum multiplied by the weight
        $sum += $v * $weight[$i];
    }

    # This is a SEDOL value if it ends in a zero
    return $sum % 10 ? 0 : 1;
}

sub main {
    my $input = shift;

    # Sanity check
    die "You must enter a value\n"             unless defined $input;
    die "The value must be seven characters\n" unless length($input) == 7;

    say _is_sedol($input);
}

main(@ARGV);
