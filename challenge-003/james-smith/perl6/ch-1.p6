use strict;

my @hammings = lazy gather {
  take 1;
  my $last = 0;
  while 1 {
    my $lowest;
    for 2,3,5 -> $n {
      for (@hammings) {
        next if $_*$n <= $last;
        $lowest = $_*$n unless $lowest && $lowest < $_*$n;
        last;
      }
    }
    take $lowest;
    $last = $lowest;
  }
}

sub MAIN($n) {
  say @hammings[$_-1] for 1..$n;
}
