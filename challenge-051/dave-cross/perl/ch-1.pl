#!/usr/bin/perl
#
# Note: As $a and $b are special variables in Perl, I've used
# $x, $y and $z instead of $a, $b and $c.

use strict;
use warnings;
use feature 'say';

my $target = 0;

my @numbers = sort { $a <=> $b } grep { /^-?\d+$/  } @ARGV;

die "Usage: $0 [list of integers]\n" unless @numbers;

for my $i (0 .. $#numbers - 1) {
  my $x     = $numbers[$i];
  my $start = $i + 1;
  my $end   = $#numbers;

  while ($start < $end) {
    my $y = $numbers[$start];
    my $z = $numbers[$end];

    if ($x + $y + $z == $target) {
      say "($x, $y, $z)";
      $start++;
      $end--;
    } else {
      if ($x + $y + $z > $target) {
        $end--;
      } else {
	$start++;
      }
    }
  }
}
