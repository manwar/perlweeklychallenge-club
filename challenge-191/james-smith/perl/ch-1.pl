#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = 200_000;

my @Q = qw( 55    5   50  100   58   32   24   86   88   28   82   72   19   35   34   38   53   73   96   31   37   74   75   83   23   22   81   61   49   59    7   33   80   20   43   90   98    6    8   57   70   47   36   92   21    1   67   63   27   42    2   52   62   95   99   91   10   84    9   39   85   79   16   46   97   15   87   78   77   25   54   12   13   64   94   48   17   51   26   45   66   18   11   56   29   65   40   60   76   69   14    4   44   41   68   30   89    3   93   71
);
#print join ', ', map { rand <=> rand } 1..100; exit;

my @TESTS = (  [
 [ [1,2,3,4], -1 ],
 [ [1,2,0,5],  1 ],
 [ [2,6,3,1],  1 ],
 [ [4,5,2,3], -1 ],
],
[
 [ [1,2,3,4,1,2,3,4], -1 ],
 [ [1,2,0,5,1,2,0,1],  1 ],
 [ [2,6,3,1,2,3,3,1],  1 ],
 [ [4,5,2,3,4,5,2,3], -1 ],
],
[
  [ [@Q,200],  1 ],
  [ [@Q,199], -1 ],
],
[
  [ [@Q,@Q,200],  1 ],
  [ [@Q,@Q,199], -1 ],
],
[
  [ [@Q,@Q,@Q,@Q,200],  1 ],
  [ [@Q,@Q,@Q,@Q,199], -1 ],
],
);

for my $T ( @TESTS ) {
  is( is_double( @{$_->[0]} ), $_->[1] ) for @{$T};
  is( is_double_sort( @{$_->[0]} ), $_->[1] ) for @{$T};
}
done_testing();
for my $T ( @TESTS ) {
  cmpthese( -1, {
    'max'  => sub { is_double(     @{$_->[0]}) for @{$T} },
    'sort' => sub { is_double_sort(@{$_->[0]}) for @{$T} },
  });
}

sub is_double {
  my( $f, $s ) = ( shift, shift );           # First two numbers
  ( $f, $s ) = ( $s, $f ) if $f < $s;        # Switch if 1st < 2nd
  $_>$f ? ( ( $f, $s ) = ( $_, $f ) )        # For each number
        : ( $_ > $s && ( $s = $_ ) ) for @_; #   if > 1st
                                             #     demote 1st to 2nd
                                             #     replace 1st
                                             #   if > 2nd
                                             #     demote 2nd
  $f >= 2*$s|| -1                            # Check condition
}

sub is_double_sort {
  sub {$_[0]>=2*$_[1]||-1}->(sort {$b<=>$a} @_)
}
