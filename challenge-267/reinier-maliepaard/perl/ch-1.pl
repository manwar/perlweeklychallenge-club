#!/usr/bin/perl
use strict;
use warnings;
#-------------------------------------------
sub product_sign {
	
    foreach (@_) {

        return 0 if ( grep {$_ == 0} @_ );
        return -1 if ( (my $n = grep {$_ < 0} @_) % 2 != 0 );

    }	
    return 1;    
}

# TESTS

my @ints = ();

# Example 1
@ints = (-1, -2, -3, -4, 3, 2, 1);
print(product_sign(@ints), "\n"); # Output: 1

# Example 2
@ints = (1, 2, 0, -2, -1);
print(product_sign(@ints), "\n"); # Output: 0

# Example 3
@ints = (-1, -1, 1, -1, 2);
print(product_sign(@ints), "\n"); # Output: -1
