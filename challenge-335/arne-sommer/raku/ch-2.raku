#! /usr/bin/env raku

unit sub MAIN (*@moves where @moves.elems > 0
                 && all(@moves) ~~/^<[012]> \, <[012]>$/,
               :v(:$verbose));

my @board = [ [ '-', '-', '-' ], ['-', '-', '-'], ['-', '-', '-'] ];

my $player = 'A';

for @moves -> $move
{
  my ($x, $y) = $move.split(",");

  die "Position $x,$y already taken" unless @board[$x][$y] eq "-";
  
  @board[$x][$y] = $player;

  $player = $player eq 'A' ?? 'B' !! 'A'; 
}

if $verbose
{
  say ": " ~ @board[0].join(" ");
  say ": " ~ @board[1].join(" ");
  say ": " ~ @board[2].join(" ");
}

for 'A', 'B' -> $ab
{
  if all(@board[0;*]) eq $ab ||
     all(@board[1;*]) eq $ab ||
     all(@board[2;*]) eq $ab ||
     all(@board[*;0]) eq $ab ||
     all(@board[*;1]) eq $ab ||
     all(@board[*;2]) eq $ab ||
     @board[0][0] eq @board[1][1] eq @board[2][2] eq $ab ||
     @board[2][0] eq @board[1][1] eq @board[0][2] eq $ab
  {
    say $ab;
    exit;
  }
}

say @moves.elems == 9 ?? 'Draw' !! 'Pending';
