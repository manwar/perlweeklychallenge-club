#!/usr/bin/env raku

use Text::CSV; # Imports `csv` function

sub challenge(Str $file-path) returns Str {
  my @lines = csv(in => $file-path, headers => "auto");
  say ('name', |@lines.map(*<name>));
  my $names = ('name', |@lines.map(*<name>)).join(',');
  my $ages  = ('age', |@lines.map(*<age>)).join(',');
  my $sexes = ('sex', |@lines.map(*<sex>)).join(',');
  ($names, $ages, $sexes).join("\n");
}

multi sub MAIN(Str $file-path) {
  say challenge($file-path);
}

multi sub MAIN(Bool :$test) {
  use Test;

  # Create a file for testing
  my $test-file = 'test.csv';
  $test-file.IO.spurt("name,age,sex\n", :append);
  $test-file.IO.spurt("Mohammad,45,m\n", :append);
  $test-file.IO.spurt("Joe,20,m\n", :append);
  $test-file.IO.spurt("Julie,35,f\n", :append);
  $test-file.IO.spurt("Cristina,10,f\n", :append);

  my $expected = "name,Mohammad,Joe,Julie,Cristina\nage,45,20,35,10\nsex,m,m,f,f";

  is(challenge($test-file), $expected);

  # Delete when we're done
  $test-file.IO.unlink;

  done-testing;
}
