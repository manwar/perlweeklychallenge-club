#!/usr/bin/env perl

use Modern::Perl;

# Task #2
# Contributed by Neil Bowers
# ASCII bar chart

# Write a function that takes a hashref where the keys are labels and the values are integer or floating point values. Generate a bar graph of the data and display it to stdout.

# The input could be something like:

# $data = { apple => 3, cherry => 2, banana => 1 };
# generate_bar_graph($data);
# And would then generate something like this:

#  apple | ############
# cherry | ########
# banana | ####
# If you fancy then please try this as well: (a) the function could let you specify whether the chart should be ordered by (1) the labels, or (2) the values.

use List::Util 'max';
use Getopt::Long;
GetOptions( "val" => \my $order_by_values ) or die;

my $data = { apple => 3, cherry => 2, banana => 1 };

say generate_bar_graph( $data, $order_by_values );

sub generate_bar_graph
{
    my $data            = shift;
    my $order_by_values = shift // 0;
    my $max_bar_length  = 12;           # length of the longest bar

    # determine highest value
    my $max_value = max values $data->%*;

    # determine longest label
    my $max_length = max map { length $_ } keys $data->%*;

    my $graph;
    for my $label ( sort { $order_by_values ? $data->{$b} <=> $data->{$a} : $a cmp $b } keys $data->%* ) {
        my $value      = $data->{$label};
        my $bar_length = int( $value / $max_value * $max_bar_length );
        $graph .= sprintf "%*s | %s\n", $max_length, $label, '#' x $bar_length;
    }

    return $graph;
}
