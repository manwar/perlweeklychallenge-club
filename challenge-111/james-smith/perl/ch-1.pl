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

## Create a test set - numbers from -10 to 60...
my %TEST_SET = map { $_ => 0 } (-10..60);
## Set all to 0 and then set all in matrix to 1
$TEST_SET{$_} = 1 foreach map { @{$_} } @{$matrix};

is( find_val( 35, $matrix ), 0 );
is( find_val( 39, $matrix ), 1 );
is( find_val(  3, $matrix ), 1 );
is( find_val(  8, $matrix ), 0 );
is( find_val( 23, $matrix ), 1 );
is( find_val( 41, $matrix ), 0 );

## Full test set! Try all numbers from -10 to 60
## { either side of the list! }
is( find_val( $_, $matrix ), $TEST_SET{$_} )
  foreach sort {$a<=>$b} keys %TEST_SET;

done_testing();

sub find_val {
  my( $val, $m, @list ) = ( $_[0], 0, map { @{$_} } @{$_[1]} );

    $list[ $m = @list >> 1 ] == $val ? ( return 1            )
  : $list[ $m              ] >  $val ? ( splice @list, $m    )
  :                                    ( splice @list, 0, $m )
    while @list>1;
  return @list && $list[0] == $val ? 1 : 0;
}

