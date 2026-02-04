#!/usr/bin/perl
use strict;
use warnings;

sub digital_root {
    my $number = shift;
    my $steps = 0;

    while ($number >= 10) {
        my $sum = 0;
        # split forces string context on its second argument,
        # so a numeric scalar is automatically stringified:
        $sum += $_ for (split //, $number);
        $number = $sum;
        $steps++;
    }

    return ($number, $steps);
}

# Tests

my $int;

# Example 1
$int = 38;
printf "Digital Root = %d Persistence = %d\n", digital_root($int); # Persistence  = 2, Digital Root = 2

# Example 2
$int = 7;
# printf "Digital Root = %d Persistence = %d\n", digital_root($int); # Persistence  = 0 Digital Root = 7

# Example 3
$int = 999;
# printf "Digital Root = %d Persistence = %d\n", digital_root($int); # Persistence  = 2 Digital Root = 9

# Example 4
$int = 1999999999;
printf "Digital Root = %d Persistence = %d\n", digital_root($int); # Persistence  = 3 Digital Root = 1

# Example 5
$int = 101010;
# printf "Digital Root = %d Persistence = %d\n", digital_root($int); # Persistence  = 1 Digital Root = 3
