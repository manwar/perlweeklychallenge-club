use strict;

my @line = ();

sub next_line {
  @line[$_] = @line[$_-1]+(@line[$_]||0) for reverse 1..@line;
  @line[0]=1;
  return @line;
}

sub MAIN($n) {
  say join ' ',next_line() for 1..$n;
}

