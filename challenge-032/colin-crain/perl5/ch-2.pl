#! /opt/local/bin/perl
#
#       grapher.pl
#
#       PWC32 - 2
#           Write a function that takes a hashref where the keys are labels and
#           the values are integer or floating point values. Generate a bar
#           graph of the data and display it to stdout.
#
#           The input could be something like:
#               $data = { apple => 3, cherry => 2, banana => 1 };
#               generate_bar_graph($data);
#
#           And would then generate something like this:
#
#               apple | ############
#               cherry | ########
#               banana | ####
#
#           If you fancy then please try this as well: (a) the function could
#           let you specify whether the chart should be ordered by (1) the
#           labels, or (2) the values.
#
#
#
#       colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $data = {
    'a' => 10.3,
    'b' => 20.9,
    'c' => 35,
    'd' => 85.5,
    'f' => 2,
    'h' => -85.5,
    'i' => 83.5
};

generate_graph_80( $data );


## ## ## ## ## SUBS

sub generate_graph_simple {
## a simplest version, with horizontal bars and each 'x' representing the count of 1
## this can't handle negative values
    my $data = shift;
    foreach (sort keys $data->%*) {
        say "$_\t", '=' x $data->{$_};
    };
}

sub generate_graph_80 {
## normalizes the data set to span 80 increments, rounding individual points to the nearest
## also adds a x-axis label.
## normalizing sets the start at the smallest value, so the vacant bar is not an error.
#
## adding an auto-adjustment to the x-axis would be the next step, but this is
## not obvious in its implementation, as there are no constraints placed on the input data.
## the algoritm needs to discreetly step up units when appropriate.
## for example this example would be more clear if the axis ranged from -100 to +100, but
## automatically selecting that from the given data is complex.
## adjusting the bars to the selected axis sequence is just a variant application of the
## techniques used here for normalization.
    my $data = shift;

    my $width = 80;
    my ($min, $max, $range) = get_range( $data );

    foreach (sort keys $data->%*) {
        my $normalized = ($data->{$_} - $min) * $width / $range;
        my $adjusted_value = round( $normalized );

        printf "%9s |%-s\n", $_, '=' x $adjusted_value;
    };

    my $x_axis;
    $x_axis = join '', map { $_ % 4 == 0 ? "|" : "-"} ( 0..($width) );
    printf "%9s %-s\n", "", $x_axis;

    my $x_numeric;
    for my $idx ( 0..($width) ) {
        my $point = sprintf "%-7s " , $min + ($range / $width * $idx) ;
        $x_numeric .= $idx % 8 == 0 ? $point : "";
    }
    printf "%9s %s\n", "", $x_numeric;
}

sub round {
## rounds positive and negative integer and float data correctly
    return int($_[0] + $_[0]/abs($_[0]*2 || 1));
}

sub get_range {
## given a hashref containing a data set, finds the minimum, maximum, and absolute range of values
    my $data = shift;
    my @values = sort {$a <=> $b}  values $data->%*;
    my ($min, $max) = ($values[0], $values[(scalar @values) - 1]);
    my $range = $max - $min;
    return ($min, $max, $range);

}
