#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);

use Test::More;

is( smallest_number_sort( qw(200 1 -2 2 5 1000 -6 3000 ),6001..9001,3,4,3401..5900 ), 6 );
is( smallest_number_sort( qw(5 2 -2 0)                                             ), 1 );
is( smallest_number_sort( qw(1 8 -1)                                               ), 2 );
is( smallest_number_sort( qw(-10 -8 -1)                                            ), 1 );
is( smallest_number_sort( qw(2 0 -1)                                               ), 1 );

done_testing;

sub smallest_number_sort {
  my @q = sort { $a <=> $b } grep {$_>0} @_; ## Need +ve in order!
  return 1 unless @q;                        ## No positive integers - avoids warn in next line
  for( $_=1; $_ == shift @q; $_++  ) {}      ## Loop through from 1.. exit loop if the array
                                             ##   value isn't equal to index (1-based)
  return $_;                                 ## return value...
}
