#!/usr/bin/env perl
use strict;
use warnings;

# You are given MAC address in the form i.e. hhhh.hhhh.hhhh.

# Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.

# Example 1
# Input:  1ac2.34f0.b1c2
# Output: 1a:c2:34:f0:b1:c2
# Example 2
# Input:  abc1.20f1.345a
# Output: ab:c1:20:f1:34:5a

sub convert_mac {
    my $mac = shift;

    return $mac =~ s/(..)(..)\.(..)(..)\.(..)(..)/$1:$2:$3:$4:$5:$6/r;
}

use Test::More;

is convert_mac('1ac2.34f0.b1c2'), '1a:c2:34:f0:b1:c2', 'example 1';
is convert_mac('abc1.20f1.345a'), 'ab:c1:20:f1:34:5a', 'example 2';

done_testing;