#!/usr/bin/env perl
#
# 6 out of 49 is a German lottery.
# 
# Write a script that outputs six unique random integers from the range 1 to 49.
# Output
# 
# 3
# 10
# 11
# 22
# 38
# 49

use strict;
use warnings;

sub six_outof_fortynine
{
    my %h;

    while (keys %h < 6) {
        $h{int(rand(48))+1}++;
    }
    return sort {$a <=> $b} keys %h;
}

for my $i (1..10) {
    printf "%2d %s\n", $i, join('-', map { sprintf("%2d", $_) } six_outof_fortynine());
}

exit 0;


