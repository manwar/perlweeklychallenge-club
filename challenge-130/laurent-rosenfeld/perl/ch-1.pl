#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my %histo;
$histo{$_}++ for (2, 5, 4, 4, 5, 5, 2);
say join " ", grep { $histo{$_} % 2 } keys %histo;
