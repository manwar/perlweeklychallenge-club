#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-027/
# Task #2
# Write a script that allows you to capture/display historical data.
# It could be an object or a scalar. For example
# my $x = 10; $x = 20; $x -= 5;
# After the above operations, it should list $x historical value in order.

use strict;
use warnings;

my $x;
my $x_ops= 'my $x = 10; $x = 20; $x -= 5;';

my @log;
push @log, eval $_ for (split /;/, $x_ops);
print join "\n",@log;
