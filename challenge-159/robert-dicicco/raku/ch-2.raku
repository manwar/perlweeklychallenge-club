use v6;

use Prime::Factor;

# AUTHOR: Robert DiCicco
# DATE: 7-APR-2022
# Challenge 159 Moebius Number ( Raku )

sub SquareFree (@arr) {
  my %dvals = ();

  for @arr -> $num {
    %dvals{$num}:exists ?? return(0) !! %dvals{$num} = 1
  }

  return 1;
}

sub getPrimeFactorCount (@arr ) {
  my $sz = @arr.elems;

  # return 1 if even number of factors

  if ($sz % 2 == 0 ) { return(1) }

  # return 0 if odd number of factors

  return(0);
}

sub MAIN (Int $num) {
  print("Input: n = $num\n");

  my @arr = prime-factors($num);
  my $pf = getPrimeFactorCount(@arr);
  my $sf = SquareFree(@arr);

  if (($pf == 1) && ($sf == 1)) {        # has even number of prime factors and is square free
    print("Output: 1\n");
  } elsif (($pf == 0) && ($sf == 1)) {   # has odd number of prime factors and is square free
    print("Output: -1\n");
  } elsif ( $sf == 0 ) {                 # number is not square free
    print("Output: 0\n");
  } else { die "Error!!!"};              # something is wrong!!
}
