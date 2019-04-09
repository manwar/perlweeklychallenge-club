use strict;
use feature ':5.10';

my @hammings = ();

sub next_hamming {
  my $lowest = 1;
  local $_;
  ## Find first multiple of 2,3,5 > max hamming no in array
  my $n = 5; my @other = (3,2);
  foreach (@hammings) {
    next if $_*$n <= $hammings[-1];
    $lowest = $_*$n if $lowest == 1 || $lowest > $_*$n;
    last unless @other;
    $n = shift @other;
    redo;
  }
  push @hammings, $lowest;
  return $lowest;
}

say next_hamming() foreach 1..shift;
