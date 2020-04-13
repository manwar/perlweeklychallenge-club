use v6 ;

sub myCondition( @array --> Bool ) {
  my @doublets = @array.rotor(2 => -1) ;
  my $len = @doublets.elems ;
  my @trues ;
  for (0..$len - 1 ) -> $i {
      if ( $i %% 2 ) {
    @trues.push( @doublets[$i][0] >= @doublets[$i][1] ) ;
      }
      else {
    @trues.push( @doublets[$i][ 0 ] <= @doublets[$i][ 1 ] ) ;
      }
  }
  return @trues.grep( { $_ == True } ).elems == $len ;
}

sub MAIN( ) {
  my $num ;
  my @theArray ;
  $num = prompt "Enter a number (negative number to stop) : " ;
  while ( $num > 0 ) {
      @theArray.push( $num ) ;
      $num = prompt "next number! " ;
  }
  .say for @theArray.permutations.grep( { myCondition( @_) } ) ;
}
