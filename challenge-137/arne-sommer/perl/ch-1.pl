#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use DateTime;

my $lower = 1900;
my $upper = 2100;

my @long_years;

for my $year ($lower .. $upper)
{
  push(@long_years, $year) if DateTime->new(year => $year, month => 12, day => 31)->week_number() == 53;
}

say join(", ", @long_years);
