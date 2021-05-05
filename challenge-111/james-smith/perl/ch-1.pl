#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

## Today's is an interesting challenge ... to check to
## see if a value is in the matrix....
##
## Initially this looks like we need to define some
## efficient sorting algorithm to flatten the array
## and then search it
##
## We implement this... but we compare it against some
## alternative simple methods. We don't get the result
## we expect...
##
## We use cmpthese to compare the performance...
##
## Our methods are:
##
##  find_val_search - this is the binary search on
##                    the flattened array
##  find_grep_map   - use grep to compare the value
##                    on the flattened array
##  find_map_grep   - foreach row use grep to compare
##                    values, and join these together
##                    with map
##
## Timings using Benchmark cmpthese
##
##            Rate   Search Grep-Map Map-Grep  Flatten
## Search   4808/s       --     -11%     -33%     -43%
## Grep-Map 5376/s      12%       --     -25%     -36%
## Map-Grep 7143/s      49%      33%       --     -15%
## Flatten  8403/s      75%      56%      18%       --
##
## Flatten is for comparison - it actually
## does nothing other than flatten the array - this
## highlights how efficient each algorithm is
##
## So we see that the map_grep solution is 50% more
## efficient than the search algorith (this is true
## for all search method algorithms which flatten
## the array first);
##
## With this in mind we look for one final method
## which doesn't flatten the matrix into a single
## array... this time we perform a search for each
## row - to find the row we are on...
## and then use grep to search this...
##
##                  Rate  Map-Grep Flatten Don't flatten
## Map-Grep       6667/s        --    -21%          -65%
## Flatten        8475/s       27%      --          -55%
## Don't flatten 18868/s      183%    123%            --
##
## We can see that this method is nearly 3 times
## as efficient as the "most effective" search on the
## matrix by using map in some way...
##

my $matrix = [
  [  1,  2,  3,  5,  7 ],
  [  9, 11, 15, 19, 20 ],
  [ 23, 24, 25, 29, 31 ],
  [ 32, 33, 39, 40, 42 ],
  [ 45, 47, 48, 49, 50 ],
];

## Create a test set - numbers from -10 to 60...
my %TEST_SET = map { $_ => 0 } (my @KEYS = -10..60);

## Set all to 0, and then iterate through the
## elements of the matrix and set the numbers
## in the list to 1....

$TEST_SET{$_} = 1 foreach map { @{$_} } @{$matrix};

## Run the original PWC test examples...
is( find_val_search(   35, $matrix ), 0 );
is( find_val_search(   39, $matrix ), 1 );
is( find_val_map_grep( 35, $matrix ), 0 );
is( find_val_map_grep( 39, $matrix ), 1 );
is( find_val_grep_map( 35, $matrix ), 0 );
is( find_val_grep_map( 39, $matrix ), 1 );
is( find_val_dnf(      35, $matrix ), 0 );
is( find_val_dnf(      39, $matrix ), 1 );
is( find_val_dnf_x(      35, $matrix ), 0 );
is( find_val_dnf_x(      39, $matrix ), 1 );

## Now run our full test set - from -10 to 60. This covers
## all cases within the list and a few either side...

is( find_val_dnf_x(    $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_dnf(      $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_search(   $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_map_grep( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_grep_map( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;

done_testing();

cmpthese(100_000, {
  q(X)             => sub { find_val_dnf_x(    $_, $matrix ) foreach @KEYS; },
  q(Don't flatten) => sub { find_val_dnf(      $_, $matrix ) foreach @KEYS; },
  'Flatten'        => sub { flatten(           $_, $matrix ) foreach @KEYS; },
  'Search'         => sub { find_val_search(   $_, $matrix ) foreach @KEYS; },
  'Grep-Map'       => sub { find_val_grep_map( $_, $matrix ) foreach @KEYS; },
  'Map-Grep'       => sub { find_val_map_grep( $_, $matrix ) foreach @KEYS; },
});

sub find_val_dnf {
  my($v,$m) = @_;
  return $v < $m->[0][0] || $v > $m->[4][4]
       ? 0
       : 0 + grep { $v == $_ } @{$m->[ $v < $m->[3][0]
           ? ( $v < $m->[1][0] ? 0 : $v < $m->[2][0] ? 1 : 2 )
           : ( $v < $m->[4][0] ? 3 : 4                       )
         ]};
}
sub find_val_dnf_x {
  my($v,$m) = @_;
  my $t;
  return $v < $m->[0][0] || $v > $m->[4][4]
       ? 0
       : ( $t = $m->[ $v < $m->[3][0]
           ? ( $v < $m->[1][0] ? 0 : $v < $m->[2][0] ? 1 : 2 )
           : ( $v < $m->[4][0] ? 3 : 4                       )
         ] ) &&
         ( return $v == $t->[2] ? 1 :
                  $v < $t->[2] ?
                  (( $v == $t->[0] || $v == $t->[1] ) ? 1 : 0) :
                  (( $v == $t->[4] || $v == $t->[3] ) ? 1 : 0) );
}

sub flatten {
  my @list = map { @{$_} } @{$_[1]};
  return 1;
}

sub find_val_map_grep {
  my($v,$m)=@_;
  return 0 + map { grep { $_ == $v } @{$_} } @{$m};
}

sub find_val_grep_map {
  my($v,$m)=@_;
  return 0 + grep { $_ == $v } map { @{$_} } @{$m};
}

sub find_val_search {
  ## Flatten the array provided into a list...
  my( $val, $m, @list ) = ( $_[0], 0, map { @{$_} } @{$_[1]} );

  ## We trim the list depending on the value of the middle point
  ## If it matches we return 1 o/w we throw the middle value and
  ## the other half of the list - by using splice...

  ## Note rather than dividing by 2 to get the mid point of the
  ## list we instead use the bit shift operator ">>" this
  ## also has the effect of taking the integer value of the
  ## result so instead of having to do int(3/2) you can just
  ## write 3>>1 to get the whole number (1)

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

sub find_val_no_comments {
  my( $val, $m, @list ) = ( $_[0], 0, map { @{$_} } @{$_[1]} );
    $list[ $m = @list >> 1 ] == $val ? ( return 1              )
  : $list[ $m              ] >  $val ? ( splice @list, $m      )
  :                                    ( splice @list, 0, $m+1 )
    while @list>1;
  return @list && $list[0] == $val ? 1 : 0;
}

