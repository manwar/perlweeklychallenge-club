use v6;

# AUTHOR: Robert DiCicco
# DATE: 15-MAR-2022
# Challenge 156 Pernicious Numbers ( Raku )

sub sum_of_digits ( $binval ) {
  my $digsum = 0;
  for ($binval.comb) {
    $digsum += $_;
  }

  is-prime($digsum) ?? return $digsum !! return -1;
}

sub MAIN () {
  my $TARGET = 10;
  my $i = 1;
  my $cnt = 0;
  my @outarr;

  while $cnt < $TARGET {
    my $binval = sprintf("%06B", $i);
    my $dsum = sum_of_digits($binval);

    if ($dsum > 0 ) {
      @outarr.push($i);
      $cnt++;
    }

    $i++;
  }

  say @outarr;
}
