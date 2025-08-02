package Product::Sign;

# Write a script to find the sign of product
# of all integers in the given array.
#  The sign is 1 if the product is positive,
#  -1 if the product is negative
#  and 0 if product is zero.

sub calc {
    my ( $self, @ints ) = @_;

    my $product = 1;
    for my $x (@ints) {
        $product *= $x;
    }

    return 1  if $product > 0;
    return -1 if $product < 0;
    return 0;
}

1;
