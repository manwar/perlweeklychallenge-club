#!/usr/bin/perl

use 5.18.4; # for fc
use strict;
use warnings;

my $data   = { apple => 3, cherry => 2, banana => 1 };
my $params = { order_by => 'name' };
generate_bar_graph($data, $params);

# Generates the ASCII bar graph
sub generate_bar_graph {
    my ($data, $params) = @_;
    my $sort_func;

    # Sorting function - just 2 for now
    $sort_func = sub { $data->{$::b} <=> $data->{$::a} }
        if ($params->{order_by} eq 'size');
    $sort_func = sub { fc($::a) cmp fc($::b) }
        if ($params->{order_by} eq 'name');

    # Print the chart
    for my $key (sort $sort_func keys %$data) {
        printf("%10s | %s \n",
            $key, '#' x int(scalar($data->{$key}) * 4));
    }
}
