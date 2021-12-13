#!/usr/bin/env perl
use strict;
use warnings;

my $expr = $ARGV[0];
die "invalid expr\n" unless $expr && $expr =~ m/^[\s\d\.\+\-\*\*\(\)]*$/;
print eval($expr) . "\n";
