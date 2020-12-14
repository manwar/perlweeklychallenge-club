#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( read_numbers( 1122234 ),   21321314 );
is( read_numbers( 2333445 ),   12332415 );
is( read_numbers(   12345 ), 1112131415 );

done_testing();

sub read_numbers {
  return $_[0] =~ s{(
    (\d)  # Any digit [ this becomes \2 / $2
    (\2*) # Any other copies of the digit
  )}{(length $1).$2}regex;
}

