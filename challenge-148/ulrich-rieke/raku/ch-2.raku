use v6 ;

sub isCardanoTriplet( $triplet --> Bool) {
  my $rootPart = $triplet[1] * sqrt( $triplet[2] ) ;
  my $firstTerm = ($triplet[0] + $rootPart) ** (1/3) ;
  my $secondTerm ;
#use abs function to prevent a NaN in the computation!
  if ( $rootPart > $triplet[0] ) {
      $secondTerm = -((abs( $triplet[0] - $rootPart)) ** (1/3 )) ;
  }
  else {
      $secondTerm = ($triplet[0] - $rootPart) ** (1/3) ;
  }
  my $result = $firstTerm + $secondTerm ;
#the second condition "brute forces" solution (2 1 5) in...
  if ( $result == 1 || ~$result ~~ /^0 '.' <-[0..8]>+$/ ) {
      return True ;
  }
  else {
      return False ;
  }
}

my @sourceData = (1 .. 50 ) ;
my @cardanoTriplets ;
my @forSecondCheck ;
my @combis = @sourceData.combinations( 3 ) ;
for @combis -> $combi {
  if ( isCardanoTriplet( $combi ) ) {
      @cardanoTriplets.push( $combi ) ;
  }
  else {
      @forSecondCheck.push( $combi ) ;
  }
}
for @forSecondCheck -> $combi {
  my $permus = $combi.permutations ;
  for (0 .. $permus.elems - 1 ) -> $i {
      if ( isCardanoTriplet( $permus[$i] ) ) {
    @cardanoTriplets.push( $permus[ $i ] ) ;
      }
  }
}
my @sorted = @cardanoTriplets.sort( { $^a.sum <=> $^b.sum } ) ;
say @sorted[0 .. 4] ;
