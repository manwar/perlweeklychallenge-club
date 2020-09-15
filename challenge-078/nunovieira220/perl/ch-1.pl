#!/usr/bin/perl

use strict;
use warnings;

# Input
my @list = scalar @ARGV ? @ARGV : (9, 10, 7, 5, 6, 1);

# Get leader elements
my @arr = ();
for my $item (@list) {
  @arr = grep { $_ > $item } @arr;
  push @arr, $item;
}

# Output
my $res = join ", ", @arr;
print $res."\n";