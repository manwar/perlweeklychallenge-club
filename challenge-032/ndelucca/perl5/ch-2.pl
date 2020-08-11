#!/usr/bin/perl

# Write a function that takes a hashref where the keys are labels and the values are integer or floating point values.
# Generate a bar graph of the data and display it to stdout.

# The input could be something like:

# $data = { apple => 3, cherry => 2, banana => 1 };
# generate_bar_graph($data);

# And would then generate something like this:

# apple  | ############
# cherry | ########
# banana | ####

# If you fancy then please try this as well: (a) the function could let you specify whether the chart should be ordered by (1) the labels, or (2) the values.

use strict;
use warnings;

sub generate_bar_graph{

    my $dataRef = shift;
    my $sort_bit = shift || 2;

    my @sorted_by_value = sort { $dataRef->{$b} <=> $dataRef->{$a} } keys(%$dataRef);
    # We allways get the max value so we can graph in the same scale
    # Sacrifice speed (when asked to sort by label, we do it twice) over functionality
    my $max = $dataRef->{$sorted_by_value[0]};

    my @sorted_keys = @sorted_by_value;
    @sorted_keys = sort { $a cmp $b } keys(%$dataRef) if $sort_bit == 1;

    print "$_\t".bar($dataRef->{$_},$max)."\n" for @sorted_keys;

}

sub bar{
    my ($value,$max) = @_;
    my $scale = 60;
    my $bar_size = $value*$scale/$max;

    return "#"x$bar_size;
}

# By Value
generate_bar_graph({
    apple => 35.5,
    cherry => 12,
    banana => 60.9
});

# banana  ############################################################
# apple   ##################################
# cherry  ###########

generate_bar_graph({
    apple => 35.5,
    cherry => 12,
    banana => 60.9
},1);

# By Label
# apple   ##################################
# banana  ############################################################
# cherry  ###########
