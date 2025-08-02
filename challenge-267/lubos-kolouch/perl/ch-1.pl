use strict;
use warnings;

sub product_sign {
    my @ints = @_;

    my $negative_count = 0;
    foreach my $value (@ints) {
        return 0 if $value == 0;
        $negative_count++ if $value < 0;
    }

    return $negative_count % 2 == 0 ? 1 : -1;
}

# Test cases
use Test::More;

is(product_sign(-1, -2, -3, -4, 3, 2, 1), 1, 'Example 1');
is(product_sign(1, 2, 0, -2, -1), 0, 'Example 2');
is(product_sign(-1, -1, 1, -1, 2), -1, 'Example 3');

done_testing();

# Print results for visualization
print "Output Example 1: ", product_sign(-1, -2, -3, -4, 3, 2, 1), "\n";
print "Output Example 2: ", product_sign(1, 2, 0, -2, -1), "\n";
print "Output Example 3: ", product_sign(-1, -1, 1, -1, 2), "\n";
