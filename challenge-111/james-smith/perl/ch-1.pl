#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);
use List::Util qw(any first);


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
##  find_grep_grep  - foreach row use grep to compare
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
## So we see that the grep_grep solution is 50% more
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

my $N = @ARGV ? $ARGV[0] : 100_000;
my $matrix = [
  [  1,  2,  3,  5,  7 ],
  [  9, 11, 15, 19, 20 ],
  [ 23, 24, 25, 29, 31 ],
  [ 32, 33, 39, 40, 42 ],
  [ 45, 47, 48, 49, 50 ],
];

my @M = @{$matrix};
my $A = [ map { @{$_} } @M ];
my $H = {};
@{$H}{@{$A}}=();

## Create a test set - numbers from -10 to 60...
my %TEST_SET = map { $_ => 0 } (my @KEYS = -10..60);
## Set all to 0, and then iterate through the
## elements of the matrix and set the numbers
## in the list to 1....
$TEST_SET{$_} = 1 foreach map { @{$_} } @{$matrix};


my $tests = {
  'Search'     => sub { find_val_search (       $_, $matrix ) foreach @KEYS; },
  'GrepGrep'   => sub { find_val_grep_grep(      $_, $matrix ) foreach @KEYS; },
  'GrepMap'    => sub { find_val_grep_map(      $_, $matrix ) foreach @KEYS; },
  'GrepExt'    => sub { find_val_grep_grep_ext( $_, $matrix ) foreach @KEYS; },
  'Flatten'    => sub { flatten(                 $_, $matrix ) foreach @KEYS; },

  'DNF'        => sub { find_val_dnf(           $_, $matrix ) foreach @KEYS; },
  'DNFOpt'     => sub { find_val_dnf_optimal(   $_, $matrix ) foreach @KEYS; },
  'DNFGen'     => sub { find_val_general_dnf(   $_, $matrix ) foreach @KEYS; },

  'Hash'       => sub { find_val_hash(          $_, $matrix ) foreach @KEYS; },
  'Flatten@'   => sub { flatten_array(           $_, @M      ) foreach @KEYS; },

  'ListUtil'   => sub { find_val_list_util(     $_, $matrix ) foreach @KEYS; },
  'AnyAny'     => sub { find_val_any_any(       $_, $matrix ) foreach @KEYS; },
  'AANaive'    => sub { find_val_any_any_naive( $_, $matrix ) foreach @KEYS; },

  'preHash'    => sub { find_val_hash_pre(       $_, $H      ) foreach @KEYS; },
  'preGrep'    => sub { find_val_grep_pre(       $_, $A      ) foreach @KEYS; },
};

is( find_val_any_any_naive( 35, $matrix ), 0 );
is( find_val_any_any_naive( 39, $matrix ), 1 );
is( find_val_any_any_naive( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_list_util( 35, $matrix ), 0 );
is( find_val_list_util( 39, $matrix ), 1 );
is( find_val_list_util( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_any_any( 35, $matrix ), 0 );
is( find_val_any_any( 39, $matrix ), 1 );
is( find_val_any_any( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_hash_pre( 35, $H ), 0 );
is( find_val_hash_pre( 39, $H ), 1 );
is( find_val_hash_pre( $_, $H ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_grep_pre( 35, $A ), 0 );
is( find_val_grep_pre( 39, $A ), 1 );
is( find_val_grep_pre( $_, $A ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_search( 35, $matrix ), 0 );
is( find_val_search( 39, $matrix ), 1 );
is( find_val_search( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_hash( 35, $matrix ), 0 );
is( find_val_hash( 39, $matrix ), 1 );
is( find_val_hash( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_grep_grep( 35, $matrix ), 0 );
is( find_val_grep_grep( 39, $matrix ), 1 );
is( find_val_grep_grep( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_grep_grep_ext( 35, $matrix ), 0 );
is( find_val_grep_grep_ext( 39, $matrix ), 1 );
is( find_val_grep_grep_ext( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_grep_map( 35, $matrix ), 0 );
is( find_val_grep_map( 39, $matrix ), 1 );
is( find_val_grep_map( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_dnf( 35, $matrix ), 0 );
is( find_val_dnf( 39, $matrix ), 1 );
is( find_val_dnf( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_dnf_optimal( 35, $matrix ), 0 );
is( find_val_dnf_optimal( 39, $matrix ), 1 );
is( find_val_dnf_optimal( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_general_dnf( 35, $matrix ), 0 );
is( find_val_general_dnf( 39, $matrix ), 1 );
is( find_val_general_dnf( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;


done_testing();
cmpthese( $N, $tests );

sub find_val_grep_grep_ext {
  my($v,$m)=@_;
  return $v<$m->[0][0] || $v > $m->[-1][-1] ? 0 : 0 + grep { $v>=$_->[0] && $v<=$_->[-1] && grep { $_ == $v } @{$_} } @{$m};
}

sub find_val_list_util {
  my($v,$m) = @_;
  my $t =  first { $_->[-1] >= $v } @{$m};
  return ($t && any { $v == $_ } @{$t}) ? 1 : 0;
}

sub find_val_any_any {
  my($v,$m) = @_;
  return (any { $v>=$_->[0] && $v <=$_->[-1] && (any { $_ == $v } @{$_}) } @{$m}) ? 1 : 0;
}
sub find_val_any_any_naive {
  my($v,$m) = @_;
  return (any { any { $_ == $v } @{$_} } @{$m}) ? 1 : 0;
}

sub find_val_general_dnf {
  my($v,$m)=@_;
  return 0 if$v<$m->[0][0]||$v>$m->[-1][-1];
  my($n,$l,$r)=(0,0,@{$m}-1);
  $v>$m->[$n=($l+$r)>>1][-1]?($l=$n+1):($r=$n)while$r!=$l;
  ($l,$r)=(0,@{$m=$m->[$l]}-1);
  ($v==$m->[$n=($l+$r)>>1])?(return 1):$v>$m->[$n]?($l=$n+1):($r=$n-1)while$l<=$r;
  return 0;
}

sub find_val_dnf {
  my($v,$m) = @_;
  return $v < $m->[0][0] || $v > $m->[4][4]
       ? 0
       : 0 + grep { $v == $_ } @{$m->[ $v < $m->[3][0]
           ? ( $v < $m->[1][0] ? 0 : $v < $m->[2][0] ? 1 : 2 )
           : ( $v < $m->[4][0] ? 3 : 4                       )
         ]};
}
sub find_val_dnf_optimal {
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
                  ( $v == $t->[0] || $v == $t->[1] ? 1 : 0) :
                  ( $v == $t->[4] || $v == $t->[3] ? 1 : 0) );
}

sub flatten_array {
  shift @_;
  my @list = map { @{$_} } @_;
  return 1;
}

sub flatten {
  my @list = map { @{$_} } @{$_[1]};
  return 1;
}

sub find_val_hash {
  my %list;
  @list{ map { @{$_} } @{$_[1]} } = ();
  return exists $list{$_[0]} ? 1: 0;
}

sub find_val_hash_pre {
  return exists $_[1]{$_[0]} ? 1: 0;
}

sub find_val_grep_grep {
  my($v,$m)=@_;
  return 0 + grep { grep { $_ == $v } @{$_} } @{$m};
}

sub find_val_grep_map {
  my($v,$m)=@_;
  return 0 + grep { $_ == $v } map { @{$_} } @{$m};
}

sub find_val_grep_pre {
  my($v,$m)=@_;
  return 0 + grep { $_ == $v } @{$m};
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

