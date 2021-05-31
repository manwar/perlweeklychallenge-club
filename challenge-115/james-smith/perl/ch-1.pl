#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( biggest_even(4,1,7,6), 7614 );
is( biggest_even(1,4,2,8), 8412 );
is( biggest_even(1,0,2,6), 6210 );
is( biggest_even(1,7,9,6), 9716 );
is( biggest_even(1,7,3,5), ''   );

done_testing();

sub biggest_even {
  my $ptr = my @digits = reverse sort @_;
  ## Firstly grab the digits in reverse numerical order
  ## Keep looping backwards through the array until we
  ## find a digit which is even - if this is the case
  ## we move it to the back and return the list.
  $digits[$ptr]&1 || return join'',@digits[0..$ptr-1,$ptr+1..$#digits,$ptr] while $ptr--;

  ## If we get to the start return 0 as there are no even digits!
  return '';
}

