#!/usr/bin/perl

# Challenge 032
#
# Task #2
# Contributed by Neil Bowers
# ASCII bar chart
# Write a function that takes a hashref where the keys are labels and the
# values are integer or floating point values. Generate a bar graph of the
# data and display it to stdout.
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
# If you fancy then please try this as well: (a) the function could let you
# specify whether the chart should be ordered by (1) the labels, or (2) the
# values.

use Modern::Perl;
use List::Util 'max';

my $data = { apple => 3, cherry => 2, banana => 1 };

sub chart {
    my($data) = @_;

    # get size of keys
    my $width = max(map {length($_)} keys %$data);

    # output data
    for my $key (sort keys %$data) {
        say sprintf("%*s | %s", $width, $key, "##" x $data->{$key});
    }
}

chart($data);
