#!/usr/bin/env raku

sub challenge(@list-of-lists, Int $N) returns Int {
  my $output = 0;
  for (0..^@list-of-lists.end) Z (0^..@list-of-lists.end) -> ($i, $j) {
    if @list-of-lists[$i].head == $N || @list-of-lists[$j].head == $N {
      $output = 1;
      last;
    } elsif @list-of-lists[$i].head < $N < @list-of-lists[$j].head {
      $output = (any(@list-of-lists[$i][1..*]) ~~ $N).Int;
      last;
    } elsif $j == @list-of-lists.end && $N > @list-of-lists[$j].head {
      $output = (any(@list-of-lists[$j][1..*]) ~~ $N).Int;
      last;
    }
  }
  $output;
}

multi sub MAIN(Int $N) {
  my @list-of-lists = (
    ( 1,  2,  3,  5,  7),
    ( 9, 11, 15, 19, 20),
    (23, 24, 25, 29, 31),
    (32, 33, 39, 40, 42),
    (45, 47, 48, 49, 50)
  );
  say challenge(@list-of-lists, $N);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @list-of-lists = (
    ( 1,  2,  3,  5,  7),
    ( 9, 11, 15, 19, 20),
    (23, 24, 25, 29, 31),
    (32, 33, 39, 40, 42),
    (45, 47, 48, 49, 50)
  );

  is(challenge(@list-of-lists, 35), 0);
  is(challenge(@list-of-lists, 39), 1);
  is(challenge(@list-of-lists, 47), 1);

  done-testing;
}
