use strict;

my @hammings = lazy gather {
  take 1;
  my $last = 0;
  while 1 {
    my $lowest;
    my $n = 5; my @other = (3,2);
    for (@hammings) {
      next if $_*$n <= $last;
      $lowest = $_*$n unless $lowest && $lowest < $_*$n;
      last unless @other;
      $n = shift @other;
      redo;
    }
    take $lowest;
    $last = $lowest;
  }
}

sub MAIN($n) {
  say @hammings[$_-1] for 1..$n;
}
