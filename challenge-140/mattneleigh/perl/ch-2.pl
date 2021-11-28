#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arguments = (
    [ 2, 3, 4 ],
    [ 3, 3, 6 ]
);

foreach(@arguments){
    printf(
        "Input: \$i = %d; \$j = %d; \$k = %d\n",
        $_->[0], $_->[1], $_->[2]
    );
    printf(
        "Output: %d\n\n",
        kth_element_multiplication_table(@{$_})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Find a specified member of a sorted multiplication table
# Takes three arguments:
# * The maximum, I, from one series of multiplicands
# * The maximum, J, from one series of multiplicands
# * The number, K, of the desired product within the sorted multiplication
#   table
# Returns on success:
# * The Kth element of the sorted table
# Returns on error:
# * undef if K is outside the table (there are not at least K elements in the
#   table)
################################################################################
sub kth_element_multiplication_table{
    my $i = shift();
    my $j = shift();
    my $k = shift();

    my @products;
    my $j_orig = $j;

    # Generate a list of products
    while($i--){
        $j = $j_orig;
        while($j--){
            push(@products, ($i + 1) * ($j + 1));
        }
    }

    # Sort the products in ascending order
    # and return the Kth element of the list
    @products = sort({$a <=> $b} @products);

    return($products[$k - 1]);

}



