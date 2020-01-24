#!/usr/local/bin/perl
use 5.016;
use warnings;

use List::MoreUtils qw(mesh);

my @operators = ( '', '+', '-' );  # Interleave these between digits
my $n = 0;

my @digits = split //, '123456789';

while ( 1 )
{
  my @ops = ternary( $n );
  my @interleave = ( map { $operators[$_] } @ops, 0 ); # Mesh wants same sizes
  my @formula = mesh @digits, @interleave;
  my $expr = join '', @formula;
  my $res = eval $expr;
  say "$expr = $res" and exit if $res == 100;
  $n++;
}


sub ternary
{
  my $n = shift;

  my @value;
  while ( $n )
  {
    unshift @value, $n % 3;
    $n = int( $n / 3 );
  }
  @value > 8 and die "No solution found";
  unshift @value, (0)x(8-@value);         # zero fill
  return @value;
}
