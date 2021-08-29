#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use Perl6::Junction qw/all any/;

no warnings qw(experimental::signatures);

my $string = $ARGV[0] // "x * * * x * x x x x | * * * * * * * * * x | * * * * x * x * x * | * * * x x * * * * * | x * * * x * * * * x";

my @board;
my @size;

for my $row (split(/\s*\|\s*/, $string))
{
  my @row = split(/\s+/, $row);
  die "Illegal character(s)" unless all(@row) eq any("x", "*");
  push(@board, \@row);
  push(@size, scalar @row);
}

die "Uneven row length" unless all(@size) == $size[0];

for my $row (0 .. scalar @board -1)
{
  for my $col (0 .. scalar @{$board[$row]} -1)
  {
    print get_cell($row, $col, @board), " ";
  }
  say "";
}

sub get_cell ($row, $col, @board)
{
  return 'x' if $board[$row][$col] eq 'x';

  my $count = 0;

  for my $row_offset (-1, 0, 1)
  {
    for my $col_offset (-1, 0, 1)
    {
      next if $row_offset == $col_offset && $col_offset == 0;
      next unless $board[$row + $row_offset][$col + $col_offset];
      next if $row + $row_offset < 0;
      next if $col + $col_offset < 0;

      $count++ if $board[$row + $row_offset][$col + $col_offset] eq "x";
    }
  }
  return $count;
}


