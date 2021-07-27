#!/usr/bin/perl

# Perl Weekly Challenge - 123
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-123/#TASK2
#
# Task 1 - Square Points
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(frequency arrayify);
use Data::Printer;

use Test::More;

# Prototype(s)
sub areSquarePoints(\@);
sub dist(\@\@);


my $tests = [ 
   [ [10,20],[20,20],[20,10],[10,10], 1 ],
   [ [12,24],[16,10],[20,12],[18,16], 0 ],
   [ [10,24],[12,24],[10,12],[18,16], 0 ],
   [ [20,20],[20,10],[10,10],[10,20], 1 ],
   [ [ 0, 1],[ 1, 2],[ 2, 1],[ 1, 0], 1 ],
];

foreach my $t (@$tests) {
  my $res = pop(@$t);
  is(areSquarePoints(@$t),$res);
}

done_testing();


sub areSquarePoints(\@) {
  my ($ar) = @_;

  my @dP;

  # If all points given are coordinates of a square
  # then the distance between one point and the other three
  # will give 2 identical and on other
  foreach my $i (0 .. 3) {
    my @d;
    foreach my $j (0 .. 3) {
      next if ($i == $j);
      push(@d,sqrt(($ar->[$i][0]-$ar->[$j][0])**2 +
                   ($ar->[$i][1]-$ar->[$j][1])**2));
    }
    my %f = frequency @d;
    push(@dP,[keys %f]);
  }

  # If all four points give same distance 'frequencies'
  # then we have a square
  my %f = frequency arrayify @dP;

  return 1 if (scalar keys %f == 2);

  return 0;
}

