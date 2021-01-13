#!/usr/bin/perl

# Perl Weekly Challenge - 079
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#
# Task 2 - Trapped Rain Water
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(min max);
use List::MoreUtils qw(uniq indexes);


my (@N) = @ARGV;
@N = (1, 2, 1, 1, 10, 3, 4, 1, 2, 7, 2, 2, 4, 1, 2, 1, 3, 2) 
  unless scalar @N;

die "N must be a list of at least 3 positive integer values"
  unless (scalar @N >= 3 and !scalar(grep { !/^[1-9][0-9]*$/ } @N));


my $grid = createHistGrid(\@N);
printHistogram('Input:', $grid, \@N);
my $trappedWater = findAndFillGaps(\@N, $grid);
printHistogram('Output:', $grid, \@N, $trappedWater);


sub createHistGrid {
  my ($arList) = @_;

  my $grid = [];

  my $max = max(@$arList);

  foreach my $y (0 .. $max - 1) {
    foreach my $x (0 .. scalar @$arList - 1) {
      $grid->[$x][$y] = ($arList->[$x] > $y ? '#' : ' ');
    }
  }

  return $grid;
}      


sub findAndFillGaps {
  my ($arL, $grid) = @_;

  my $dropsAdded = 0;

  my @list = @$arL;

  my @levels = sort {$b <=> $a } uniq(@list);

  foreach my $level (@levels) {
    my @i = indexes { $_ >= $level } @list;
    next unless (scalar(@i) > 1);

    do {
      my $i = shift(@i);
      last if (!defined $i[0]);

      if ($i[0] - $i > 1) {
        my $fillLevel = min($list[$i], $list[$i[0]]);

        for my $j ($i + 1 .. $i[0] - 1) { 
          for my $k ($list[$j] + 1 .. $fillLevel) {
            $grid->[$j][$k - 1] = '.';
          }
          $dropsAdded += ($fillLevel - $list[$j]);
          $list[$j] = $fillLevel;
        }
      }
    } while (scalar @i > 1);
  }

  return $dropsAdded;
}


sub printHistogram {
  my ($caption, $arGrid, $arList, $trappedWater) = @_;

  my $max = max(@$arList);
  my $yLw = length($max);

  print "$caption\n";

  # Print histogram rows
  for (my $row = $max; $row > 0; $row--) {
    my @row = (sprintf("%${yLw}s", $row), '|');
    for my $col (0 .. scalar(@$arList) - 1) {
      push(@row, $grid->[$col][$row - 1]);
    }
    print join(" ", @row)."\n";
  }

  # Print X-axis
  print sprintf("%${yLw}s +%s\n",
                '',
                join('-', map { '-' } @$arList, ''));

  # Print X labels
  for my $l (0 .. $yLw - 1) {
    print sprintf("%${yLw}s   %s\n",
                  '',
                  join(' ', map { substr($_.' ' x $yLw, $l, 1) } @$arList));
  }

  if (defined $trappedWater) {
    printf "\nAmount of trapped waterdrops: %d (marked with '.' in histogram).\n", $trappedWater;
  }

  print "\n";
}
