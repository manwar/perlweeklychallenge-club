#!/usr/bin/env raku

sub challenge(Str $file-path) returns Str {
  $file-path
    .IO
    .lines
    .grep(* ~~ /
      ^
      <space>*
      [\+<digit> ** 2 | \(<digit> ** 2\) | <digit> ** 4]
      <space>
      <digit> ** 10
      $
    /)
    .join("\n");
}

multi sub MAIN(Str $file-path) {
  say challenge($file-path);
}

multi sub MAIN(Bool :$test) {
  use Test;

  # Create a file for testing
  my $test-file = 'test.txt';
  $test-file.IO.spurt("0044 1148820341\n", :append);
  $test-file.IO.spurt(" +44 1148820341\n", :append);
  $test-file.IO.spurt("  44-11-4882-0341\n", :append);
  $test-file.IO.spurt("(44) 1148820341\n", :append);
  $test-file.IO.spurt("  00 1148820341\n", :append);

  my $expected = "0044 1148820341\n +44 1148820341\n(44) 1148820341";

  is(challenge($test-file), $expected);

  # Delete when we're done
  $test-file.IO.unlink;

  done-testing;
}
