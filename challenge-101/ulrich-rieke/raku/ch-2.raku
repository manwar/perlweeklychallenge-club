use v6 ;

sub enterPoints( ) {
  my @points ;
  for (1 .. 3) {
      say "Enter point coordinates, separated by a blank!" ;
      my $line = $*IN.get ;
      my @coordinates = $line.split( /\s+/ ) ;
      @points.push( [|@coordinates] ) ;
  }
  return @points ;
}

sub findEquation( [$x1, $y1] , [$x2, $y2] ) {
  my $m ;
  my $b ;
  if ( $x1 != $x2 ) {
      $m = ($y1 -$y2) / ($x1 - $x2) ;
  }
  if ( $m.defined ) {
      $b = $y1 - $m * $x1 ;
  }
  if ( $m.defined and $b.defined ) {
      return ( $m, $b ) ;
  }
  else {
      return ( ) ;
  }
}

my @points = enterPoints( ) ;
my $output = 0 ;
#a point lies inside the triangle if we can add 2 vectors which
#are parallel to BA and to CA so that the ratios of the vectors to
#BA ( w1 ) and to CA (w2) are both positive and add up to a number
#not larger than 1
#point P is inside the triangle if the following equation holds true:
#P = A + w1( B - A ) + w2( C - A )
#we need 2 equations to find w1 and w2, and we use the corresponding
#equation for the x and y coordinate for that.
#by solving this by hand, we get this for w1:
#w1 =  (Ax(Cy -Ay) + (Py -Ay )(Cx - Ax)- Px(Cy -Ay )) /
#      ((By -Ay )( Cx - Ax ) - (Bx -Ax ) (Cy -Ay))
#w2 can be obtained by entering w1 into:
#w2 = (Py -Ay -w1(By -Ay)) / (Cy -Ay )
my $w1 = (@points[0][0] * ( @points[2][1] - @points[0][1] ) +
      (0 - @points[0][1] ) * (@points[2][0] - @points[0][0] )) /
      ((@points[1][1] - @points[0][1]) - (@points[1][0] - @points[0][0] )
      * (@points[2][1] - @points[0][1] )) ;
my $w2 = (-@points[0][1] - $w1 * (@points[1][1] - @points[0][1])) /
  (@points[2][1] - @points[0][1] ) ;
if ( $w1 >= 0 and $w2 >= 0 and ($w1 + $w2) <= 1 ) {
  $output = 1 ;
}
else {#it might be on the edge and not inside !
  my @equations ;
  my @result = findEquation( @points[0] , @points[1] ) ;
  if ( @result ) {
      @equations.push( [|@result] ) ;
  }
  @result = findEquation( @points[1] , @points[2] ) ;
  if ( @result ) {
      @equations.push( [|@result] ) ;
  }
  @result = findEquation( @points[0] , @points[2] ) ;
  if ( @result ) {
      @equations.push( [|@result] ) ;
  }
  for @equations -> $res {
#we have to check y = mx + b ; with y = 0 and x = 0, only b == 0 is required
      if ( $res[1] == 0 ) { #it's on the edge!
    $output = 1 ;
    last ;
      }
  }
}
say $output ;
