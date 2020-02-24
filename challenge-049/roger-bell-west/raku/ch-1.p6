#! /usr/bin/perl6


for @*ARGS -> $n {
  my $t=$n;
  while (1) {
    if ($t ~~ /^<[01]>+$/) {
      say $t;
      last;
    } else {
      $t+=$n;
    }
  }
}
