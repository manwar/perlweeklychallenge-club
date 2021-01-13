#!/usr/bin/perl

# Perl Weekly Challenge - 089
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-089/
#
# Task 2 - Magical Matrix
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Unbuffered STDOUT
$|++;

use List::Util qw(sum shuffle);
use Memoize;

# Prototype
sub checkSolution(\@);
sub printSolution (\@);

memoize('sum', 'checkSolution');

# Give an extra command-line argument to invoke 'cheat-mode'
my @n= (1..4, 6..9);
push(@n, 5) unless (@ARGV);

my @s;

# Brute force try to find a solution
# (but memoize for some performance)
while (1) {
  @s = shuffle(@n);
  # splice '5' in the centre in 'cheat-mode'
  splice(@s, 4, ,1, 5, $s[4]) if (@ARGV);
  last if checkSolution(@s);
}
printSolution(@s);


sub checkSolution (\@) {
  my ($ar) = @_;

  return 1 if (
    # rows
    sum($ar->[0], $ar->[1], $ar->[2]) == 15 and
    sum($ar->[3], $ar->[4], $ar->[5]) == 15 and
    sum($ar->[6], $ar->[7], $ar->[8]) == 15 and
    # columns
    sum($ar->[0], $ar->[3], $ar->[6]) == 15 and
    sum($ar->[1], $ar->[4], $ar->[7]) == 15 and
    sum($ar->[2], $ar->[5], $ar->[8]) == 15 and
    # diagonals
    sum($ar->[0], $ar->[4], $ar->[8]) == 15 and
    sum($ar->[2], $ar->[4], $ar->[6]) == 15
  );
}


sub printSolution (\@) {
  my ($ar) = @_;

  for my $r (0..2) {
    printf("%d %d %d\n",
      $ar->[$r * 3], 
      $ar->[$r * 3 + 1],
      $ar->[$r * 3 + 2]
    );
  }
}
