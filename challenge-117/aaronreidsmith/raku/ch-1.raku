#!/usr/bin/env raku

use Lingua::EN::Numbers;

sub challenge(Str $file) returns Str {
  my $nums     = $file.IO.lines.map(*.split(',').head.Int).List;
  my $sum      = $nums.sum;
  my $expected = (1..$nums.elems + 1).sum;
  my $missing  = $expected - $sum;
  "$missing, Line {cardinal($missing)}";
}

multi sub MAIN(Str $file) {
  say challenge($file);
}

multi sub MAIN(Bool :$test) {
  use Test;

  for (1, 12, 15) -> $missing {
    my $test-file = 'test.txt';

    my @range      = 1..15;
    my @randomized = @range.pick(@range).grep(* != $missing);

    for @randomized -> $i {
      $test-file.IO.spurt("$i, Line {cardinal($i)}\n", :append);
    }

    is(challenge($test-file), "$missing, Line {cardinal($missing)}");

    $test-file.IO.unlink
  }
}
