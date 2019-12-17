#!/usr/bin/env perl
#
# ch-1.pl - Remove leading zeroes from positive numbers
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

# Accept filenames or standard input

# The spec was a bit vague, so I'm choosing to only modify numbers that start
# at the beginning of a line. Change the ^ to a \b to work on any number
print s/^0+(?=[1-9])//r while (<<>>);

# Another cheeky way about it, if you are certain you only have +ve ints:
# say 0+$_ while (<<>>);
