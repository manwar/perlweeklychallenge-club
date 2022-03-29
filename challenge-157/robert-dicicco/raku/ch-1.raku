use v6;

# AUTHOR: Robert DiCicco
# DATE: 22-MAR-2022
# Challenge 157 Pythagorean Means ( Raku )

sub arithmetic( $a ) {

  my $sum = 0;
  my $len = ($a.elems) - 1;

  for 0..$len -> $x {
     $sum += $a[$x];
  }

  my $amrnd = sprintf("%.1f", $sum / ($len + 1));

  print "AM = $amrnd  ";
}

sub geometric( $a ) {

  my $prod = 0;
  my $len = ($a.elems) - 1;

  for 0..$len -> $x {
    if $prod == 0 {
      $prod = $a[$x];
    } else {
      $prod *= $a[$x];
    }
  }

  my $gmrnd = sprintf("%.1f", $prod ** (1/($len+1)));

  print "GM = $gmrnd  ";
}

sub harmonic( $a ) {

  my $len = ($a.elems) - 1;
  my $sum = 0;

  for 0..$len -> $x {
    $sum += 1/$a[$x];
  }

  my $hmrnd = sprintf("%.1f", ($len+1)/$sum);

  say "HM = $hmrnd  ";
}

my @inp = < 1 2 3 4 5 >;

arithmetic( @inp);
geometric( @inp);
harmonic( @inp );
