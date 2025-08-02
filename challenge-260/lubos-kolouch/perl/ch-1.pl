package  ch1;
use strict;
use warnings;

use Data::Dumper;

sub unique_occurrences {
    my @ints = @_;
    my %count;

    # Count occurrences of each value in the array
    $count{$_}++ for @ints;

    # Check if the number of occurrences is unique
    my %occurrences_count;
    foreach my $value ( values %count ) {
        $occurrences_count{$value}++;
    }

    # Return 1 if all occurrences are unique, 0 otherwise
    return ( scalar keys %occurrences_count == scalar values %count ) ? 1 : 0;
}

# Example 1
my @ints1 = ( 1, 2, 2, 1, 1, 3 );
print "Example 1: " . unique_occurrences(@ints1) . "\n";

# Example 2
my @ints2 = ( 1, 2, 3 );
print "Example 2: " . unique_occurrences(@ints2) . "\n";

# Example 3
my @ints3 = ( -2, 0, 1, -2, 1, 1, 0, 1, -2, 9 );
print "Example 3: " . unique_occurrences(@ints3) . "\n";

1;
