use v6 ;

#we do not assume a full-fledged Nim game with a number of different rows but
#rather a one-row game with 12 pieces according to the given task ( the number
#of combinations would very much depend on the number of rows, the pieces in
#them and the constraint "draw all pieces from one row"

#in humandraw, we assume some amount of naivete....
sub humandraw( Int $parts is rw ) {
  my $takeaway = prompt( "How many pieces do you want to take ? " ) ;
  while ( $takeaway > 3 ) {
      say "don't take more than 3 pieces!" ;
      $takeaway = prompt( "How many pieces do you want to take ?" ) ;
  }
  $parts -= $takeaway ;
  say "We now have $parts pieces!" ;
  return $parts ;
}

#we force the opposition to end with (12 - ( 3 + 1 )) so it can't win
#we should end up at (12 - ( 3 + 1 ) - 4 * n ) so that the opposition
#can't win( reference: Wikipedia about Bachet's game )
sub computerdraw( Bool $firstDraw , Int $parts is rw ) {
  my $takeaway ;
  if ( $firstDraw ) {#we probably can't stop the opposition from reaching 4 so
#in this case $takeaway doesn't really matter
      $takeaway = 2 ;
  }
  else {
      if ( 8 < $parts < 12)  {
    $takeaway = $parts - 8 ;
      }
      if ( 4 < $parts < 8 ) {
    $takeaway = $parts - 4 ;
      }
      if ( $parts == 4 ) {#we are lost anyway
    $takeaway = (1,2,3).pick ;
      }
      if ( $parts == 8 ) {
    $takeaway = 1 ;
      }
      if ( 0 < $parts < 4 ) {
    $takeaway = $parts ;
      }
  }
  $parts -= $takeaway ;
  say "I took $takeaway piece(s)!" ;
  say "We now have $parts pieces!" ;
  return $parts ;
}

my $pieces = 12 ;
my Bool $firstDraw = True ;
#who is to start ?
my $number = (0,1).pick( 1 ) ;
if ( $number == 0 ) {
  say "You start!" ;
  $firstDraw = False ;
  while ( $pieces > 0 ) {
      $pieces = humandraw( $pieces ) ;
      if ( $pieces == 0 ) {
    say "You won!" ;
    last ;
      }
      $pieces = computerdraw( $firstDraw , $pieces ) ;
      if ( $pieces == 0 ) {
    say "I won!" ;
    last ;
      }
    }
}
else {
  say "I start!" ;
  while ( $pieces > 0 ) {
      $pieces = computerdraw( $firstDraw , $pieces ) ;
      $firstDraw = False ;
      if ( $pieces == 0 ) {
    say "I won!" ;
    last ;
      }
      $pieces = humandraw( $pieces ) ;
      if ( $pieces == 0 ) {
    say "You won!" ;
    last ;
      }
    }
}
