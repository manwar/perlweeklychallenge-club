#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use List::MoreUtils qw(first_index);
use Data::Dumper::OneLine;

# Input
my @N = (
  [0, 0, 0, 2, 6, 0, 7, 0, 1],
  [6, 8, 0, 0, 7, 0, 0, 9, 0],
  [1, 9, 0, 0, 0, 4, 5, 0, 0],
  [8, 2, 0, 1, 0, 0, 0, 4, 0],
  [0, 0, 4, 6, 0, 2, 9, 0, 0],
  [0, 5, 0, 0, 0, 3, 0, 2, 8],
  [0, 0, 9, 3, 0, 0, 0, 7, 4],
  [0, 4, 0, 0, 5, 0, 0, 3, 6],
  [7, 0, 3, 0, 1, 8, 0, 0, 0]
);

# Solve
my %safes = createSafes();

solve();

# Output
say Dumper($_) for(@N);

# Solve sudoku game
sub solve {
  my $row = -1;
  my $col = -1;

  for (my $i = 0; $i < 9; $i++) {
    my $index = first_index { $_ == 0 } @{$N[$i]};

    if ($index > -1) {
      $row = $i;
      $col = $index;
      last;
    }
  }

  return 1 if ($col == -1);

  my $result = 0;
  for (my $val = 1; $val <= 9; $val++) {
    if (isSafe($row, $col, $val)) {
      addSafeValue($row, $col, $val);

      $result = solve();
      last if ($result);

      removeSafeValue($row, $col, $val);
    }
  }

  return $result;
}

# Test if element is safe
sub isSafe {
  my ($row, $col, $val) = @_;

  return 0 if (grep(/^$val$/, @{$safes{$row}{9}}));
  return 0 if (grep(/^$val$/, @{$safes{9}{$col}}));
  return 0 if (grep(/^$val$/, @{$safes{squareIndex($row)}{squareIndex($col)}}));
  return 1;
}

# Create and fill safe list
sub createSafes {
  my %result = ();

  for(my $i = 0; $i < 9; $i++) {
    $result{$i}{9} = [];

    for(my $j = 0; $j < 9; $j++) {
      $result{9}{$j} = [] if($i == 0);

      my $val = $N[$i][$j];
      my $iSquare = squareIndex($i);
      my $jSquare = squareIndex($j);

      $result{$iSquare}{$jSquare} = [] if(!defined $result{$iSquare}{$jSquare});

      if($val != 0) {
        push @{$result{9}{$j}}, $val;
        push @{$result{$i}{9}}, $val;
        push @{$result{$iSquare}{$jSquare}}, $val;
      }
    }
  }

  return %result;
}

# Add safe element
sub addSafeValue {
  my ($row, $col, $val) = @_;

  $N[$row][$col] = $val;

  push @{$safes{$row}{9}}, $val;
  push @{$safes{9}{$col}}, $val;
  push @{$safes{squareIndex($row)}{squareIndex($col)}}, $val;
}

# Remove safe alement
sub removeSafeValue {
  my ($row, $col, $val) = @_;
  my $squareRow = squareIndex($row);
  my $squareCol = squareIndex($col);

  $N[$row][$col] = 0;

  my $indexRow = first_index { $_ == $val } @{$safes{$row}{9}};
  splice(@{$safes{$row}{9}}, $indexRow, 1);

  my $indexCol = first_index { $_ == $val } @{$safes{9}{$col}};
  splice(@{$safes{9}{$col}}, $indexCol, 1);

  my $indexSquare = first_index { $_ == $val } @{$safes{$squareRow}{$squareCol}};
  splice(@{$safes{$squareRow}{$squareCol}}, $indexSquare, 1);
}

# Get square index
sub squareIndex {
  return 2 if ($_[0] < 3);
  return 5 if ($_[0] < 6);
  return 8;
}