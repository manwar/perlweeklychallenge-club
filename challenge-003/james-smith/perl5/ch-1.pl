use strict;
use feature ':5.10';

my @hammings = (1);

sub next_hamming {
  my $lowest;
  local $_;
  foreach my $n (2,3,5) {
    foreach (@hammings) {
      next if $_*$n <= $hammings[-1];
      $lowest = $_*$n unless $lowest && $lowest < $_*$n;
      last;
    }
  }
  push @hammings, $lowest;
  return $lowest;
}

say 1;
say next_hamming() foreach 1..shift;
