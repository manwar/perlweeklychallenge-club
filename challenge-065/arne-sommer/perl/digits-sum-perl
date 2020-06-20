#! /usr/bin/env perl

use strict;
use feature 'say';

my $verbose = 0;

if ($ARGV[0] eq "--verbose")
{
  $verbose = 1;
  shift @ARGV;
}

my $N     = shift @ARGV || die "No 'N' value";
my $S     = shift @ARGV || die "No 'S' value";

die "Illegal 'N' value" if int($N) ne $N && $N <= 1;
die "Illegal 'S' value" if int($S) ne $S && $S <= 1;

my $start = 10 ** ($N - 1);
my $stop  = (10 ** $N) -1;
my @all   = ($start .. $stop);
my @some  = grep { get_sum($_) == $S } @all;

say ": Max Range ($start .. $stop)" if $verbose;

say join(", ", @some);

sub get_sum
{
  my $integer = shift;
  my $sum = 0;
  for my $digit (split(//, $integer))
  {
    $sum += $digit;
  }
  return $sum;
}
