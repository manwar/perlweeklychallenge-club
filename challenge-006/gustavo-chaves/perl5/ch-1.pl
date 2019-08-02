#!/usr/bin/env perl

# Create a script which takes a list of numbers from command line and print the
# same in the compact form. For example, if you pass “1,2,3,4,9,10,14,15,16”
# then it should print the compact form like “1-4,9,10,14-16”.

use strict;
use warnings;

# The script should be invoked with a single argument which is a comma-separated
# list of integers in ascending order.

my ($from, @list) = split /,/, shift;
my $to = $from;

foreach my $n (@list) {
    if ($n > $to + 1) {
        print $from == $to ? "$to," : "$from-$to,";
        $from = $n;
    }
    $to = $n;
}

print $from == $to ? "$to\n" : "$from-$to\n";
