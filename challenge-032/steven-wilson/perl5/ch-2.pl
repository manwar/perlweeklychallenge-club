#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-28
# Week: 032

# Task #2
# Contributed by Neil Bowers
# ASCII bar chart
#
# Write a function that takes a hashref where the keys are labels and
# the values are integer or floating point values. Generate a bar graph
# of the data and display it to stdout.
#
# The input could be something like:
#
# $data = { apple => 3, cherry => 2, banana => 1 };
# generate_bar_graph($data);
# And would then generate something like this:
#
#  apple | ############
# cherry | ########
# banana | ####
# If you fancy then please try this as well: (a) the function could let
# you specify whether the chart should be ordered by (1) the labels, or
# (2) the values.

# generate_bar_graph ( $data); # sort by keys
# generate_bar_graph ( $data, 'l'); # sort by keys
# output:
#  apple | ###
# banana | #
# cherry | ##

# generate_bar_graph ( $data, 'v'); # sort by values
# output:
#  apple | ###
# cherry | ##
# banana | #

use strict;
use warnings;
use feature qw/ say /;

my $data = { apple => 3, cherry => 2, banana => 1 };

generate_bar_graph( $data, 'v' );

sub generate_bar_graph {
    my $bar_graph_data_ref = shift;
    my %bar_graph_data     = %{$bar_graph_data_ref};
    my $max_length_key     = get_max_length_keys($bar_graph_data_ref);
    my $sort_by            = ( defined $_[0] and $_[0] eq 'v' ) ? 'v' : 'l';
    my @sorted_keys        = get_sorted_keys( $bar_graph_data_ref, $sort_by );
    for my $key (@sorted_keys) {
        say sprintf '%*3$s | %s',
            $key, '#' x $bar_graph_data{$key}, $max_length_key;
    }
}

sub get_sorted_keys {
    my $bar_graph_data_ref = shift;
    my %bar_graph_data     = %{$bar_graph_data_ref};
    my $sort_by            = shift;
    my @sorted_keys;
    if ( $sort_by eq 'l' ) {
        @sorted_keys = sort keys %bar_graph_data;
    }
    else {
        @sorted_keys
            = reverse sort { $bar_graph_data{$a} <=> $bar_graph_data{$b} }
            keys %bar_graph_data;
    }
    return @sorted_keys;
}

sub get_max_length_keys {
    my $bar_graph_data_ref = shift;
    my %bar_graph_data     = %{$bar_graph_data_ref};
    my $max_length_key     = 0;
    for my $key ( keys %bar_graph_data ) {
        $max_length_key = length $key if length $key > $max_length_key;
    }
    return $max_length_key;
}
