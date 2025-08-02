#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ 1, 2, 4, 3, 5, 6 ],
    [ 0, 2, 4, 8, 3, 5 ],
    [ 7, 3, 1, 0, 5, 9 ],
);

for my $example (@examples) {
    my $str    = join ', ', $example->@*;
    my $output = distinct_average( $example->@* );
    say <<"END";
    Input:  \$str = ($str)
    Output: $output
END
}

sub distinct_average(@ints) {
    # we're given an unsorted array but sorted would be more useful
    # and we lose nothing 
    @ints = sort { $a <=> $b } @ints;
    my %output;
    # we remove the highest and lowest (first and last)
    # elements from a list, average them, and add the values 
    # to a hash
    while ( @ints ) {
        my $min = shift @ints;
        my $max = pop @ints;
        my $avg = ( $min + $max ) / 2;
        $output{$avg}++;
    }
    # we don't care about how many times each get used, 
    # merely the count
    return scalar keys %output;
}
