use strict;
use warnings;
use List::Util qw/min max/;

sub max_product_sublist {
    my @nums = @_;
    my $max_product = $nums[0];
    my $min_product = $nums[0];
    my $result = $nums[0];

    for my $i (1 .. $#nums) {
        if ($nums[$i] < 0) {
            ($max_product, $min_product) = ($min_product, $max_product);
        }

        $max_product = max($nums[$i], $nums[$i] * $max_product);
        $min_product = min($nums[$i], $nums[$i] * $min_product);

        $result = max($result, $max_product);
    }

    return $result;
}

my @input = (2, 5, -1, 3);
my $max_product = max_product_sublist(@input);
print "Maximum product: $max_product\n";  # Output: Maximum product: 10

