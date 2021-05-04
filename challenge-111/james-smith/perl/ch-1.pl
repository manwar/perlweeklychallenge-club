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

## Set all to 0, and then iterate through the
## elements of the matrix and set the numbers
## in the list to 1....

$TEST_SET{$_} = 1 foreach map { @{$_} } @{$matrix};

## Run the original PWC test examples...
is( find_val( 35, $matrix ), 0 );
is( find_val( 39, $matrix ), 1 );

## Now run our full test set - from -10 to 60. This covers
## all cases within the list and a few either side...

is( find_val( $_, $matrix ), $TEST_SET{$_} )
  foreach sort {$a<=>$b} keys %TEST_SET;

done_testing();

sub find_val {
  ## Flatten the array provided into a list...
  my( $val, $m, @list ) = ( $_[0], 0, map { @{$_} } @{$_[1]} );

  ## We trim the list depending on the value of the middle point
  ## If it matches we return 1 o/w we throw the middle value and
  ## the other half of the list - by using splice...

    $list[ $m = @list >> 1 ] == $val ? ( return 1              )
  : $list[ $m              ] >  $val ? ( splice @list, $m      )
  :                                    ( splice @list, 0, $m+1 )
    while @list>1;

  ## We stop when we get to a list of either 0 or 1 entries.
  ## If the list has length 0 then we return 0
  ## If it has one element we return whether or not it is the value

  return @list && $list[0] == $val ? 1 : 0;

  ## The latter occurs when the true value happens at the start of
  ## list either at initially or after one of the splices...
}

