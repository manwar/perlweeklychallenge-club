use strict;
use warnings;

sub unequal_triplets {
    my @ints = @_;

    # Count the frequency of each number
    my %freq;
    $freq{$_}++ for @ints;

    my $count          = 0;
    my @unique_numbers = keys %freq;

    # Manually generate combinations using nested loops
    for my $i ( 0 .. $#unique_numbers ) {
        for my $j ( $i + 1 .. $#unique_numbers ) {
            for my $k ( $j + 1 .. $#unique_numbers ) {
                my $product =
                  $freq{ $unique_numbers[$i] } *
                  $freq{ $unique_numbers[$j] } *
                  $freq{ $unique_numbers[$k] };
                $count += $product;
            }
        }
    }

    return $count;
}

# Test the Perl solution
print unequal_triplets( 4, 4, 2, 4, 3 ), "\n";             # Expected Output: 3
print unequal_triplets( 1, 1, 1, 1, 1 ), "\n";             # Expected Output: 0
print unequal_triplets( 4, 7, 1, 10, 7, 4, 1, 1 ), "\n";   # Expected Output: 28
