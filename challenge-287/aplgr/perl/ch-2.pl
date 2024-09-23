#!/usr/bin/perl
use strict;
use warnings;

sub is_valid_number {
    my ($str) = @_;

    # Regex for valid numbers
    my $regex = qr{
        ^            # Start of the string
        [+-]?        # Optional sign
        (?:          # Start of the number group
            \d+      # Integer: at least one digit
            (?:      # Start of the optional decimal part
                \.   # Decimal point
                \d*  # Followed by zero or more digits
            )?       # Group is optional
            |        # or
            \.       # Just a decimal point
            \d+      # Followed by one or more digits
        )            # End of the number group
        (?:          # Start of the optional exponent group
            [eE]     # 'e' or 'E'
            [+-]?    # Optional sign
            \d+      # Followed by one or more digits
        )?           # Exponent is optional
        $            # End of the string
    }x;

    # Return 1 for valid, 0 for invalid
    return $str =~ $regex ? 1 : 0;
}

1;