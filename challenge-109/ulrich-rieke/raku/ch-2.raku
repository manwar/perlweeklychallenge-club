use v6 ;

sub isValid( $theCombination ) {
  if (( $theCombination[0].elems == 2 && $theCombination[1].elems == 3
    && $theCombination[2].elems == 3 && $theCombination[3].elems == 2 )
      && (($theCombination[0] (&) $theCombination[1]).elems == 1 &&
    ($theCombination[1] (&) $theCombination[2]).elems == 1 &&
    ($theCombination[2] (&) $theCombination[3]).elems == 1 )) {
      my @intersections = ( ($theCombination[0] (&) $theCombination[1]) ,
          ($theCombination[1] (&) $theCombination[2]) ,
          ($theCombination[2] (&) $theCombination[3])) ;
#the intersections should be different from each other
      return @intersections.unique.elems == 3 ;
  }
  else {
      return False ;
  }
}

#find those combinations of 4 that are possible solutions, that is
#one combination of 2 at the beginning and the end and 2 combinations
#of 3 in the middle
sub is_possibleCombination( $aCombination ) {
  if ( $aCombination[0].elems == 2 && $aCombination[1].elems == 3
    && $aCombination[2].elems == 3 && $aCombination[3].elems == 2 ) {
      return True ;
  }
  return False ;
}

my $numbers = (1 .. 7 ) ;
#we are interested in all those combinations of 2 and 3 numbers that
#share the same sum
my $commonSums = $numbers.combinations(2).map( {.sum} ) (&)
  $numbers.combinations(3).map( {.sum } ) ;
my @two_elements = $numbers.combinations( 2 ).Array;
my @three_elements = $numbers.combinations( 3 ).Array ;
my @solutions ; #holds one or more valid solutions
#sum by sum , we check whether there are at least 2 different combinations
#of 2 or 3 numbers that add up to that sum.
for $commonSums.keys -> $sum {
  my $combis_with_same_sum = Set.new( @two_elements.grep(
    {.sum == $sum })) (|)
      Set.new( @three_elements.grep( {.sum == $sum })) ;
  if ( $combis_with_same_sum.keys.elems > 0 ) {
#if we have combinations of 2 and 3 numbers with the same sum we create
#combinations of 4, pick those with 2 pairs and 2 combinations of 3 and
#permutate them to see if there is a valid solution
      my @possibleCombis ;
      if ( $combis_with_same_sum.keys.grep( { .elems == 3 } ).elems >= 2 &&
    $combis_with_same_sum.keys.grep( { .elems == 2 } ).elems >= 2 ) {
      @possibleCombis.push( $combis_with_same_sum.keys ) ;
    }
      for @possibleCombis -> $solution_candidate {
    if ( $solution_candidate.elems > 4 ) {
        my $fourCombis = $solution_candidate.combinations( 4 ) ;
        for $fourCombis <-> $element {
          for $element.Array <-> $subelement {
          if ( is_possibleCombination( $subelement )) {
            my $permus = $subelement.permutations ;
            my @permulist = $permus.Array ;
            for @permulist -> $permu {
            if ( isValid( $permu ) ) {
              @solutions.push( $permu ) ;
            }
            }
          }
          }
        }
    }
    if ( $solution_candidate.elems == 4 ) {
        if ( $solution_candidate.grep( {.elems == 2} ).elems == 2
          && $solution_candidate.grep( {.elems == 3} ).elems == 2 ) {
          my $permus = $solution_candidate.permutations() ;
          for $permus -> $permu {
          if ( is_possibleCombination( $permu ) ) {
            if ( isValid( $permu ) ) {
            @solutions.push( $permu ) ;
            }
          }
          }
        }
    }
        }
      }
}
#we have to "unwrap" the set intersection values by applying the .keys operator
#to the sets
for @solutions -> $quadruple {
  my $sum = $quadruple[0].sum ;
  my $b = $quadruple[0] (&) $quadruple[ 1 ] ;
      $b = $b.keys[0] ; #"unwrap" the value and reassign!
  my $a = $sum - $b ;
  my $d = $quadruple[1] (&) $quadruple[2] ;
      $d = $d.keys[ 0 ] ;
  my $c = $sum - ($b + $d  ) ;
  my $f = $quadruple[2] (&) $quadruple[3] ;
      $f = $f.keys[0] ;
  my $e = $sum - ( $d + $f ) ;
  my $g = $sum - $f ;
  say "a = $a" ;
  say "b = $b" ;
  say "c = $c" ;
  say "d = $d" ;
  say "e = $e" ;
  say "f = $f" ;
  say "g = $g" ;
  print "\n\n" ;
  say "Box 1: a + b = $a + $b = {$a + $b}" ;
  say "Box 2: b + c + d = $b + $c + $d = {$b + $c + $d}" ;
  say "Box 3: d + e + f = $d + $e + $f = {$d + $e + $f}" ;
  say "Box 4: f + g = $f + $g = {$f + $g}" ;
  say "---------------------------------------------------------------------------" ;
}
