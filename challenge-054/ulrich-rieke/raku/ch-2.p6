use v6 ;

sub findSequence( Int $n is copy ) {
  my @sequence ;
  while ( $n != 1 ) {
      @sequence.push( $n ) ;
      if ( $n %% 2 ) {
        $n div= 2 ;
      }
      else {
        $n = $n * 3 + 1 ;
      }
  }
  @sequence.push( $n ) ;
  return @sequence ;
}

sub MAIN( Int $n ) {
  .say for findSequence( $n ) ;
  my @sequences ;
  for (1..1000000) -> $num {
      my @sequence = findSequence( $num ) ;
      @sequences.push( ($num , @sequence.elems ) ) ;
  }
  my @sorted = @sequences.sort( { $^b[1] <=> $^a[1] } ) ;
  say "The sequence lengths of the longest sequences up to 1000000 are :" ;
  @sorted[0..19].map( { say "$_[0]  $_[1]" } ) ;
}
