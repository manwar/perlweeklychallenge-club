#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my @numbers = (10, 4, 1, 8, 12, 3);
my @indices = (0, 2, 5);

@numbers[@indices] = sort { $a <=> $b } @numbers[@indices];
say "@numbers";
