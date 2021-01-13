#!/usr/bin/env perl6

# ch-1.p6 - Compactify list of numbers
#
# Ryan Thompson <rjt@cpan.org>

use v6;

my @list = split /<[, ]>+/, join(',', @*ARGS); # Accept commas or spaces

my @delta = @list.rotate »-« @list;

@delta.say;
