#!/usr/bin/env perl
# Perl Weekly Challenge 88 task 1 array of product
# Given a matrix $N[i] produce a matrix $M[i]= of products of $N[j] excluding $N[i]
use warnings;
use strict;
use feature qw(say);

say join " ", "Example 1:", array_of_products(5,2,1,4,3);
say join " ", "Example 2:", array_of_products(2,1,4,3);
# Output:
# Example 1: 24 60 120 30 40
# Example 2: 12 24 6 8
sub array_of_products {
    use PDL; #use the perl data language
    use PDL::NiceSlice;
    my $input =pdl(@_); #input piddle (PDL array)
    my $matrix=$input(:,*$input->dim(0))->copy; #replicate row to produce a matrix
    $matrix->diagonal(0,1).=1; #replace diagonal by 1's
    my $output=$matrix->prodover; #multiply elements row-wise
    return $output->list; #convert to perl list
}
