#! /usr/bin/env perl

use strict;
use bigrat;   # -> inf
use feature 'signatures';

use Perl6::Junction 'all';
use List::Util qw/sum max/;
use Getopt::Long;
use feature 'say';

no warnings qw(experimental::signatures);

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my @N = @ARGV;

die "Please specify at least one element" unless @N;

die "Integers only" unless all(@N) == qr/^\d+$/;

push(@N, inf); unshift(@N, inf);

my %M = map { $_ => $N[$_] } 0 .. (@N -1);

my @C = (); ##  x (length(@N));

my $N_end = @N -2;

for my $index (sort { $M{$a} <=> $M{$b} } keys %M)
{
  $C[$index] = candy_count($index);
  say ": Index $index with value $M{$index} and candies $C[$index]" if $verbose;
}

if ($verbose)
{
  say ": Ranking w/border: " . join(", ", @N);
  say ": Candies w/border: " . join(", ", @C);

  say ": Ranking: " . join(", ", @N[1..$N_end]);
  say ": Candies: " . join(", ", @C[1..$N_end]);
}

say sum(@C);

sub candy_count ($index)
{
  return 0 if $index == 0 || $index == @N -1;

  return max($C[$index-1], $C[$index+1]) +1 if $N[$index] > $N[$index-1] || $N[$index] > $N[$index+1];

  return 1;
}
