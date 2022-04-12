use v6;

# AUTHOR: Robert DiCicco
# DATE: 11-APR-2022
# Challenge 160 Equilibrium Index ( Raku )

sub leftsum ( @a, Int $i is copy ) {        # get sum of the array to left of the inflection point, ($i)
  my $sum = 0;                              # this includes the inflection point

  while ( $i >= 0 ) {
    $sum += @a[$i];
    $i--;
  }

  return $sum;
}

sub rightsum ( @a, Int $i is copy ) {       # get sum of the array to right of the inflection point, ($i)
  my $sum = 0;                              # this includes the inflection point

  while ( $i < @a.elems )  {
    $sum += @a[$i];
    $i++;
  }

  return $sum;
}

sub balance (  @a ) {
  my $flag = 0;                         # the 'found' flag
  my $len = @a.elems;                   # get length of array

  for (1..$len-2) -> $i {               # step thru possible inflection points
    my $leftval  = leftsum(@a, $i);
    my $rightval = rightsum(@a,$i);
    if ($leftval == $rightval) {        # compare sums
      print "Output: $i\n\n";
      $flag++;                          # increment flag if equal
      last;
    }
  }

  if ( $flag == 0 ) {print "Output: -1 as no Equilibrium Index found.\n\n"} ;

  return;
}

sub MAIN {
  my @arr = ((1, 3, 5, 7, 9), (1, 2, 3, 4, 5 ), (2, 4, 2));

  my @subarr;
  # try each of the supplied arrays

  for ( @arr ) -> @subarr {
    print "Input: \@n = \( " ~ @subarr ~ " \)\n";
    balance(@subarr);
  }
}
