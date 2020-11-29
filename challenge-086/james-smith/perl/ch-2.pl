#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Data::Dumper qw(Dumper);

my @input = (
  [qw( _ _ _ 2 6 _ 7 _ 1 )],
  [qw( 6 8 _ _ 7 _ _ 9 _ )],
  [qw( 1 9 _ _ _ 4 5 _ _ )],
  [qw( 8 2 _ 1 _ _ _ 4 _ )],
  [qw( _ _ 4 6 _ 2 9 _ _ )],
  [qw( _ 5 _ _ _ 3 _ 2 8 )],
  [qw( _ _ 9 3 _ _ _ 7 4 )],
  [qw( _ 4 _ _ 5 _ _ 3 6 )],
  [qw( 7 _ 3 _ 1 8 _ _ _ )],
);
my @i2 = (
  [qw( _ 5 _ _ _ _ _ 8 _ )],
  [qw( 3 _ 9 _ _ _ 7 _ 2 )],
  [qw( _ 8 _ 9 _ 1 _ 3 _ )],
  [qw( _ _ 1 7 4 3 8 _ _ )],
  [qw( _ _ _ 2 _ 5 _ _ _ )],
  [qw( _ _ 5 1 9 8 4 _ _ )],
  [qw( _ 4 _ 8 _ 9 _ 6 _ )],
  [qw( 6 _ 8 _ _ _ 5 _ 1 )],
  [qw( _ 9 _ _ _ _ _ 4 _ )],
);
is( display(solve(@input)), '[ 4 3 5 2 6 9 7 8 1 ]
[ 6 8 2 5 7 1 4 9 3 ]
[ 1 9 7 8 3 4 5 6 2 ]
[ 8 2 6 1 9 5 3 4 7 ]
[ 3 7 4 6 8 2 9 1 5 ]
[ 9 5 1 7 4 3 6 2 8 ]
[ 5 1 9 3 2 6 8 7 4 ]
[ 2 4 8 9 5 7 1 3 6 ]
[ 7 6 3 4 1 8 2 5 9 ]' );

is( display(solve(@i2)), 'x' );
done_testing();

sub display {
  return join "\n", map { "[ @{[ map { ref($_) ? join '',@{$_} : $_ } @{$_} ]} ]"; } @_;
}

sub solve {
  my @grid = map { [ map { $_ eq '_' ? [1..9] : 1*$_ } @{$_} ] } @_;
  my $previous_flag = 0;
  while( 1 ) { ## Naive sweep....
    my $flag = 0;
    foreach my $i (0..8) {
      foreach my $j (0..8) {
        next unless ref $grid[$i][$j];
        my %values = map { $_=>$_ } @{$grid[$i][$j]};
        foreach (0..8) {
          delete $values{$grid[$i][$_]} if !ref $grid[$i][$_];
          delete $values{$grid[$_][$j]} if !ref $grid[$_][$j];
          my $x = 3*int($i/3) + $_%3;
          my $y = 3*int($j/3) + int($_/3);
          delete $values{$grid[$x][$y]} if !ref $grid[$x][$y];
        }
        my @Q = keys %values;
        $grid[$i][$j] = @Q == 1 ? 1*$Q[0] : \@Q;
        $flag += @Q unless @Q==1;
      }
    }
    last unless $flag;
    last if $flag == $previous_flag;
    $previous_flag = $flag;
  }
  return @grid;
}

