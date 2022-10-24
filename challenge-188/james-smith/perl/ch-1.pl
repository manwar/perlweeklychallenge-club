#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [4,5,1,6], 2, 2 ],
  [ [1,2,3,4], 2, 2 ],
  [ [1,3,4,5], 3, 2 ],
  [ [5,1,2,3], 4, 2 ],
  [ [7,2,4,5], 4, 1 ],
);

is( divisible_pairs_x($_->[0], $_->[1]    ), $_->[2] ) for @TESTS;
is( divisible_pairs($_->[0], $_->[1]    ), $_->[2] ) for @TESTS;
is( dp_nd(          $_->[0], $_->[1]    ), $_->[2] ) for @TESTS;
is( dp_other(       $_->[1], @{$_->[0]} ), $_->[2] ) for @TESTS;
is( dp(             [@{$_->[0]}],$_->[1]    ), $_->[2] ) for @TESTS;

done_testing();

cmpthese( 250_000, {
  'd_pairs' => sub { divisible_pairs($_->[0], $_->[1]    ) for @TESTS },
  'd_pairx' => sub { divisible_pairs_x($_->[0], $_->[1]    ) for @TESTS },
  'dp_nd'   => sub { dp_nd(          $_->[0], $_->[1] ) for @TESTS },
  'd_other' => sub { dp_other(       $_->[1], @{$_->[0]}  ) for @TESTS },
  'dp'      => sub { dp(             [@{$_->[0]}], $_->[1]    ) for @TESTS },
});

sub divisible_pairs {
  my( $c, $k, @l ) = ( 0, $_[1], @{$_[0]} );
  while(@l>1){
    my $a = shift@l;
    $c+=grep{ !(($a+$_)%$k) } @l;
  }
  $c
}

sub divisible_pairs_x {
  my( $c, $k, @l ) = ( 0, $_[1], @{$_[0]} );
  while(@l>1){
    $a = shift@l;
    ($a+$_)%$k || $c++ for @l;
  }
  $c
}

sub dp {
  0 + map { $a = pop @{$_[0]}; grep { !(($a+$_)% $_[1]) } @{$_[0]} } 1..@{$_[0]}
}
sub dp_nd {
  my @T=@{$_[0]};
  0 + map { $a = pop @T; grep { !(($a+$_)%$_[1]) } @T} 1..@T
}

## dp_other - flips around k and the list - so we can pass the list
## in as a list rather than a reference - because this is a list
## rather than a reference it is non-destructive without explicitly
## converting it to an array within function (like dp_nd)

sub dp_other { $b=shift; 0+map{$a=pop;grep{!(($a+$_)%$b)}@_}1..@_ }
