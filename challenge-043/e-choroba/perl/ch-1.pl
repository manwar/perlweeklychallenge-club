#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my ($red, $green, $yellow, $blue) = (9, 5, 7, 8);

my $red_green    = 11 - $red;
my $blue_yellow  = 11 - $blue;
my $black_green  = 11 - $green - $red_green;
my $black_yellow = 11 - $yellow - $blue_yellow;
my $black        = 11 - $black_green - $black_yellow;

say join ' ', $red_green, $black_green, $black, $black_yellow, $blue_yellow;
