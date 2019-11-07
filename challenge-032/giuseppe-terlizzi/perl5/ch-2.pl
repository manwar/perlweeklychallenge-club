#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-032/

# Task #2 - ASCII bar chart

# Write a function that takes a hashref where the keys are labels and the values
# are integer or floating point values. Generate a bar graph of the data and
# display it to stdout.

# The input could be something like:

#   $data = { apple => 3, cherry => 2, banana => 1 };
#   generate_bar_graph($data);

# And would then generate something like this:

#    apple | ############
#   cherry | ########
#   banana | ####

# If you fancy then please try this as well: (a) the function could let you
# specify whether the chart should be ordered by (1) the labels, or (2) the
# values.

use strict;
use warnings;

use v5.10;
use Getopt::Long;


sub generate_bar_graph {

    my ($data, $sort_by_label) = @_;

    my $sort = ($sort_by_label)
        ? sub { $a cmp $b }
        : sub { $data->{$a} <=> $data->{$b} };

    foreach my $item (sort $sort keys %{$data}) {
        my $size = $data->{$item} * 4;
        printf "%10s | %s\n", $item, '#' x $size;
    }

}

my $data = { apple => 3, cherry => 2, banana => 1, foo => 2.5, bar => 3.6 => baz => 0.4 };


say "Sort by value:";
generate_bar_graph($data);

say "\n";

say "Sort by label:";
generate_bar_graph($data, 1);

