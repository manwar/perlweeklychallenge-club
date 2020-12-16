#!/usr/bin/perl

# Perl Weekly Challenge - 091
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-091/
#
# Task 2 - Jump Game
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Unbuffered STDOUT
$|++;

use Scalar::Util qw(looks_like_number);

@ARGV = (2,123,4,1,2,99,100)
  unless (@ARGV);

my (@N) = @ARGV;

die "Please provide a list with integer number (x >= 0)"
  if (grep { !looks_like_number($_) or $_ < 0 or $_ != int($_) } @N);

printf "Input: (%s)\n\n", join(',', @N);

# Array for progress printing
my (@S) = map { ' ' x length($_) } @N;

my $i = 0;
while ($i < scalar(@N) - 1 and $N[$i] != 0) {
  my $c = ($i + $N[$i] >= scalar(@N) ? '!' : '^');
  printLocation($i, $c);
  $i += $N[$i];
}
printLocation($i, '^') if ($i == scalar(@N) - 1);

print "\n";
printf "Output: %d\n", ($i == scalar(@N) - 1 ? 1 : 0);

sub printLocation {
  my ($i, $c) = @_;

  printf "%s\n", join(' ', @N);
  printf "%s\n", join(' ', 
                      @S[0 .. $i-1], 
                      $c x length($N[$i]), 
                      @S[$i+1 .. -1]);
}
