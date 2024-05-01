#!/usr/bin/perl

use strict;
use warnings;

# Input arrays
my @items1 = ([1,1], [2,1], [3,2] );
my @items2 = (
    [2,2], [1,3]);

# Merge the arrays
my %merged_items;
foreach my $item (@items1, @items2) {
    my ($id, $quantity) = @$item;
    $merged_items{$id} += $quantity;
}

# Print the merged items
foreach my $id (sort keys %merged_items) {
    print "($id,$merged_items{$id})\n";
}