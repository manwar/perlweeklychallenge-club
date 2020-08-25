#!/usr/bin/env perl

use strict;
use warnings;

use lib './lib';
use Majority;

my @A = @ARGV;

my $maj = Majority::element(@A);

print $maj;


