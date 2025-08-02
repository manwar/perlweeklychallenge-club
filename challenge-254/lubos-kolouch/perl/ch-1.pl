use strict;
use warnings;
use feature 'say';

sub is_power_of_three {
    my ($n) = @_;

    # Documentation
    # Determines if the given number is a power of three.
    # Params:
    #   n (Integer): A positive integer
    # Returns:
    #   A boolean value: True if n is a power of three, False otherwise

    if ( $n == 0 ) {
        return 1;
    }
    while ( $n % 3 == 0 ) {
        $n /= 3;
    }
    return $n == 1;
}

# Tests
die "Test failed!" unless is_power_of_three(27) == 1;
die "Test failed!" unless is_power_of_three(0) == 1;
die "Test failed!" unless is_power_of_three(6) == 0;
say "All tests passed!";
