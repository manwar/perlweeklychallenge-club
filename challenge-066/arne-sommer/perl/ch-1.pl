#! /usr/bin/env perl

use feature 'say';
use feature 'signatures';
no warnings qw(experimental::signatures);

my $verbose = 0;

if (@ARGV && $ARGV[0] eq "--verbose")
{
  $verbose++;
  shift @ARGV;
}

my $M = shift(@ARGV) || die 'Specify $M and $N';
my $N = shift(@ARGV) || die 'Specify $N';

die '$M is not an integer' unless int($M) == $M;
die '$N is not an integer' unless int($N) == $N;

die "Unable to divide by zero" if $N == 0;

sub sign ($value)
{
  return  1 if $value  > 0;
  return  0 if $value == 0;
  return -1 if $value < 0;
}

my $count  = 0;
my $negate = sign($M) != sign($N);
my $M_abs  = abs($M);
my $N_abs  = abs($N);

say ": Negate the result: ", $negate ? 'Yes' : 'No' if $verbose;

while ($M_abs >= $N_abs)
{
  $M_abs -= $N_abs;
  $count++;

  say ": M: $M_abs N: $N_abs = $count" if $verbose;
}

if ($negate)
{
  $count = -$count;
  $count-- if $M_abs;
}

say $count;
