#!/usr/bin/env perl
use v5.40;

sub emptyGameBoard() {
  return [
    [ '_', '_', '_' ],
    [ '_', '_', '_' ],
    [ '_', '_', '_' ]
  ];
}

sub displayGameBoard(@board) {
  my $output = "Game Board:\n";
  foreach my $row (@board) {
    $output .= "[ " . join(' ', @$row) . " ]\n";
  }
  $output;
}

sub makeMove($letter, $move, $board) {
  my ($y,$x) = ($move->[0], $move->[1]);
  $board->[$y]->[$x] = $letter;
}

sub findWinner(@moves) {
  my $board = emptyGameBoard();

  my $letter = 'A';
  my $movecount = scalar(@moves);

  while (@moves) {
    my $move = shift @moves;
    makeMove($letter, $move, $board);
    $letter = ($letter eq 'A') ? 'B' : 'A';
  }

  # check rows
  for my $y (0..2) {
    return($board->[$y][0], displayGameBoard(@$board))
      if ($board->[$y][0] eq $board->[$y][1] eq $board->[$y][2])
      && $board->[$y][0] ne '_';
  }

  # check columns
  for my $x (0..2) {
    return($board->[0][$x], displayGameBoard(@$board))
      if ($board->[0][$x] eq $board->[1][$x] eq $board->[2][$x])
      && $board->[0][$x] ne '_';
  }

  # check diagonals
  return($board->[1][1], displayGameBoard(@$board))
    if (($board->[0][0] eq $board->[1][1] eq $board->[2][2])
     || ($board->[2][0] eq $board->[1][1] eq $board->[0][2]))
      && $board->[1][1] ne '_';

  # no winner
  return(
    $movecount < 9 ? 'Pending' : 'Draw',
    displayGameBoard(@$board)
  );
}

sub solution($moves) {
  my $list = join ', ', map { '[' . join(',', @$_) . ']' } @$moves;
  say qq/Input: \@moves = ($list)/;
  my ($winner, $board) = findWinner(@$moves);
  print qq/Output: $winner\n\n$board/;
}

say "Example 1:";
solution([[0,0],[2,0],[1,1],[2,1],[2,2]]);

say "\nExample 2:";
solution([[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]]);

say "\nExample 3:";
solution([[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]]);

say "\nExample 4:";
solution([[0,0],[1,1]]);

say "\nExample 5:";
solution([[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]]);

