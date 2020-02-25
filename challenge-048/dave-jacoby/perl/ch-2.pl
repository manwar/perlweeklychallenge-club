#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental::postderef experimental::signatures };

# First pass, I went crazy with iterators and had one for years
# and months and days.

# Second pass, I realized that was a bit much because you can get
# every possible day by starting at Jan 1 2000 and going forward.

# And then I was enlightened, because there can be one and only one
# zero-padded palindromic date per year, so there's a for-loop 
# giving us every year in a millenium.

# And I was using DateTime to test to see if the date was valid,
# and when DateTime fails, it dies, so I was using Try::Tiny. 
# I *FULLY* endorse the use of both of those modules, but here
# they are not necessary. 

# They are not necessary because the day of the month can only be 
# a number ending in 2, and there are no months that have 32 days,
# and no months that have less that 22 days. No testing is required;
# if you limit to days possible, given the longest months (31 days),
# you will have all the limiting you need.

# The new most clever Perl thing here is that reverse, when run on a
# scalar, will reverse the scalar, and the year, created as a number,
# becomes a string representation of that number in base-10.

for my $year ( 2000 .. 2999 ) {
	my $month = reverse substr $year, 2, 2;
	my $day   = reverse substr $year, 0, 2;
	next if $day < 1;
	next if $month < 1;
	next if $day > 31;
	next if $month > 12;
	say join '-', $month, $day, $year;
}
