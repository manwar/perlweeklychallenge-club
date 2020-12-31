use v6 ;

sub enterPairs( ) {
  say "Enter the point coordinates!" ;
  my $pairs = $*IN.get ;
  return $pairs ;
}

#every straight line is a function y = mx + b, provided it's not a vertical line
#in the main program we also deal with parallels to the x axis
sub find_m_b( $pairA , $pairB ) {
  my $m = ( $pairA[1] - $pairB[1] ) / ( $pairA[0] - $pairB[ 0 ] ) ;
  my $b = $pairA[ 1 ] - $m * $pairA[ 0 ] ;
  return [ $m , $b ] ;
}

#is a point on a given straight line that is not a vertical or horizontal line
sub onSameSlope( $m, $b , $point --> Bool ) {#point is a set
  return ($m * ($point.key)[0] + $b == ($point.key)[1] ) ;
}

my $pairstring = enterPairs( ) ;
my @pairs = $pairstring.split( /\,\s/ ) ;
my @points ;
for @pairs -> $pair {
  if ( $pair ~~ /'(' (<[+-]>?\d+) \, (<[+-]>?\d+) ')' / ) {
      @points.push( [ $0.Int , $1.Int ] ) ;
  }
}
my @points_on_line ; #here we collect the number of points on a line
#now we form combinations of 2 points that define a line
#we then check every one of the remaining points if they happen to lie on the same
#line as these 2 points and update $max_on_line accordingly
for @points.combinations( 2 ) -> $combi {
  my $pointsOnOneLine = 2 ;
  my $otherpoints = @points (-) $combi ;
  my @remainingPoints = $otherpoints.Array ; #we want to cycle through the points
  if ( $combi[0][0] == $combi[1][0] ) { #vertical line
      for @remainingPoints -> $p {
    if ( ($p.key)[0] == $combi[0][0] ) {
        $pointsOnOneLine++ ;
    }
      }
      @points_on_line.push( $pointsOnOneLine ) ;
  }
  elsif ( $combi[0][1] == $combi[1][1] ) { #parallel to x axis
      for @remainingPoints -> $p {
    if ( ($p.key)[1] == $combi[0][1] ) {
        $pointsOnOneLine++ ;
    }
      }
      @points_on_line.push( $pointsOnOneLine ) ;
  }
  else {# on the same non-vertical and non-horizontal line ?
      my ( $m , $b ) = find_m_b( $combi[0] , $combi[1] ) ;
      for @remainingPoints -> $p {
    if ( onSameSlope( $m , $b , $p ) ) {
        $pointsOnOneLine++ ;
    }
      }
      @points_on_line.push( $pointsOnOneLine ) ;
  }
}
say @points_on_line.max ;
