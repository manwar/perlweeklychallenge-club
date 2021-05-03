#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $matrix = [
  [  1,  2,  3,  5,  7 ],
  [  9, 11, 15, 19, 20 ],
  [ 23, 24, 25, 29, 31 ],
  [ 32, 33, 39, 40, 42 ],
  [ 45, 47, 48, 49, 50 ],
];

is( find_value( 35, $matrix ), 0 );
is( find_value( 39, $matrix ), 1 );
is( find_value(  3, $matrix ), 1 );
is( find_value(  8, $matrix ), 0 );
is( find_value( 23, $matrix ), 1 );
is( find_value( 41, $matrix ), 0 );

done_testing();

sub find_value {
  my( $value, $m, @list ) = ( $_[0], 0, map { @{$_} } @{$_[1]} );
     ( $m = @list >> 1          )
  && ( $list[$m] == $value      )
  ?  ( return 1                 )
  :  ( $list[$m] > $value       )
  ?  ( @list = @list[0 .. $m-1] )
  :  ( splice @list, 0, $m      ) while @list>1;
  return 0;
}

