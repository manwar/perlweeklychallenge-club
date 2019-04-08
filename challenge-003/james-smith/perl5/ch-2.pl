use strict;
use feature ':5.10';

my @line = ();

sub next_line {
  $line[$_] = $line[$_-1]+$line[$_] foreach reverse 1..@line;
  $line[0]=1;
  return \@line;
}

say "@{next_line()}" foreach 1..shift;
