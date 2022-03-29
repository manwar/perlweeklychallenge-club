use v6;

# AUTHOR: Robert DiCicco
# DATE: 28-MAR-2022
# Challenge 158 Additive Primes ( Raku )

sub sum_of_digits ( $num ) {

  my $digsum = 0;
  for ($num.comb) {
    $digsum += $_;
  }

  is-prime($digsum) ?? return $num !! return -1;
}

sub MAIN () {
  my $TARGET = 100;
  my $i = 1;
  my $cnt = 0;
  my @outarr;

  while $i < $TARGET {
    my $dsum = sum_of_digits($i);

    if (is-prime($dsum)) {
      @outarr.push($i);
    }

    $i++;
  }

  say @outarr;
}
