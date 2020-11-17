#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use experimental qw/postderef/;

sub read_board {
  my $fh = shift;
  my @board;
  while (<$fh>) {
    s/^\[\s*|\s*\]$//g;
    push @board, [ map { $_ eq "_" ? undef : $_ } split ];
  }
  return @board;
}

sub print_board {
  for my $row (@_) {
    print '[ ';
    printf "%s ", $_ // '_' for @$row;
    print "]\n";
  }
}

sub valid_row {
  my %nums;
  for my $cell ($_[0]->@*) {
    if (defined $cell && ++$nums{$cell} > 1) {
      return 0;
    }
  }
  return 1;
}

sub valid_column :prototype(\@$) {
  my %nums;
  my ($board, $col) = @_;
  for my $row (0 .. 8) {
    if (defined $board->[$row][$col] && ++$nums{$board->[$row][$col]} > 1) {
      return 0;
    }
  }
  return 1;
}

my @quadrants =
  (
   [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]],
   [[0, 3], [0, 4], [0, 5], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5]],
   [[0, 6], [0, 7], [0, 8], [1, 6], [1, 7], [1, 8], [2, 6], [2, 7], [2, 8]],

   [[3, 0], [3, 1], [3, 2], [4, 0], [4, 1], [4, 2], [5, 0], [5, 1], [5, 2]],
   [[3, 3], [3, 4], [3, 5], [4, 3], [4, 4], [4, 5], [5, 3], [5, 4], [5, 5]],
   [[3, 6], [3, 7], [3, 8], [4, 6], [4, 7], [4, 8], [5, 6], [5, 7], [5, 8]],

   [[6, 0], [6, 1], [6, 2], [7, 0], [7, 1], [7, 2], [8, 0], [8, 1], [8, 2]],
   [[6, 3], [6, 4], [6, 5], [7, 3], [7, 4], [7, 5], [8, 3], [8, 4], [8, 5]],
   [[6, 6], [6, 7], [6, 8], [7, 6], [7, 7], [7, 8], [8, 6], [8, 7], [8, 8]]
);

sub valid_quadrant :prototype(\@$) {
  my %nums;
  my ($board, $coords) = @_;
  for my $cell (@$coords) {
    my ($row, $col) = @$cell;
    if (defined $board->[$row][$col] && ++$nums{$board->[$row][$col]} > 1) {
      return 0;
    }
  }
  return 1;
}

sub valid_board :prototype(\@) {
  my $board = shift;
  for my $row (@$board) {
    return 0 unless valid_row $row;
  }
  for my $col (0 .. 8) {
    return 0 unless valid_column @$board, $col;
  }
  for my $quad (@quadrants) {
    return 0 unless valid_quadrant @$board, $quad;
  }
  return 1;
}

sub all_filled :prototype(\@) {
  my $board = shift;
  for my $row (@$board) {
    for my $cell (@$row) {
      return 0 unless defined $cell;
    }
  }
  return 1;
}

sub solve_board  {
  my $board = shift;

  for my $row (0 .. 8) {
    for my $col (0 .. 8) {
      if (!defined $board->[$row][$col]) {
        for my $num (1 .. 9) {
          my $copy = [ @$board ];
          $copy->[$row] = [ $copy->[$row]->@* ];
          $copy->[$row][$col] = $num;
          next unless valid_board @$copy;
          return $copy if all_filled @$copy;
          $copy = solve_board($copy);
          return $copy if defined $copy;
        }
        return undef;
      }
    }
  }
  if (valid_board @$board && all_filled @$board) {
    return $board;
  } else {
    return undef;
  }
}

sub task2 {
  my $fh = shift;
  my @board = read_board $fh;
  my $solved = solve_board \@board;
  if (defined $solved) {
    print_board @$solved;
  } else {
    say "No solution found.";
  }
}

task2 \*DATA;

__DATA__
[ _ _ _ 2 6 _ 7 _ 1 ]
[ 6 8 _ _ 7 _ _ 9 _ ]
[ 1 9 _ _ _ 4 5 _ _ ]
[ 8 2 _ 1 _ _ _ 4 _ ]
[ _ _ 4 6 _ 2 9 _ _ ]
[ _ 5 _ _ _ 3 _ 2 8 ]
[ _ _ 9 3 _ _ _ 7 4 ]
[ _ 4 _ _ 5 _ _ 3 6 ]
[ 7 _ 3 _ 1 8 _ _ _ ]
