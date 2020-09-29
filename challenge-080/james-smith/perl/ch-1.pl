#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);

say smallest_number_sort(qw(200 1 -2 2 5 1000 -6 3000 ),1e6..1e7,6001..9001,3,4,3401..5900);
say smallest_number_sort(qw(5 2 -2 0));
say smallest_number_sort(qw(1 8 -1));
say smallest_number_sort(qw(2 0 -1));

sub smallest_number_sort {
  my @q = sort { $a <=> $b } grep {$_>0} @_; ## Need +ve in order!
  for( $_=1; $_ == shift @q; $_++  ) {}      ## Loop through from 1.. exit loop if the array
                                             ##   value isn't equal to index (1-based)
  return $_;                                 ## return value...
}
