#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $i = shift(@ARGV);
my @n = @ARGV;

say "(", join(",", grep { $_ > $i } @n), ")";
