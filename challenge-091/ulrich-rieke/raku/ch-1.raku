use v6 ;

sub MAIN( Str $N ) {
  die "wrong data entry!" unless $N ~~ /^\d+$/ ;
  my $pos = 0 ; #here we are in the number string
  my $count = 1 ;#how many identical digits are there ?
  my $num = $N.substr( $pos , 1 ) ;
  my $output ;#this is where the final output string goes
  my $lastValue = $num ;#we initialize lastValue with the first digit
  $pos = 1 ;
  while ( $pos < $N.chars ) {
      $num = $N.substr( $pos , 1 ) ;
      if ( $num eq $lastValue ) {
    $count++ ;#count up if the digits remain the same
      }
      else {
    $output ~= ( ~$count ~ $lastValue ) ;#otherwise: add to output str.
    $lastValue = $num ; #reset last value
    $count = 1 ; #and reset the counter
      }
      $pos++ ;
  }
  if ( $count == 1 ) { #take the last letter into account!
      $output ~= ( ~$count ~ $lastValue ) ;
  }
  say $output ;
}
