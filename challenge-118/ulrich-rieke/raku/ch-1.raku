use v6 ;

sub MAIN( Int $N is copy ) {
  my $binaryString =  $N.base( 2 ) ;
  if ( $binaryString eq $binaryString.flip ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
