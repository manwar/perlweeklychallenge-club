#! /usr/bin/env raku

unit sub MAIN (Str $game = "x * * * x * x x x x | * * * * * * * * * x | * * * * x * x * x * | * * * x x * * * * * | x * * * x * * * * x");

my @board = $game.split("|")>>.words;

die "Uneven row length" unless [==] @board>>.elems;

die "Illegal character(s)" unless all( $game.split("|")>>.words.flat) eq any("x", "*"); 

for ^@board.elems -> $row
{
  for ^@(@board[$row]).elems -> $col
  {
    print get-cell(@board, $row, $col), " ";
  }
  say "";
}

sub get-cell (@board, Int $row, Int $col)
{
  return 'x' if @board[$row][$col] eq 'x';

  my $count = 0;

  for -1, 0, 1 -> $row-offset
  {
    for -1, 0, 1 -> $col-offset
    {
      next if $row-offset == $col-offset == 0;
      next unless @board[$row + $row-offset][$col + $col-offset];
      $count++ if @board[$row + $row-offset][$col + $col-offset] eq "x";
    }
  }
  return $count;
}


