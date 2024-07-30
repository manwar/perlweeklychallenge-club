use v6 ;

sub count( $word , $char ) {
   my $total = 0 ;
   for (0..$word.chars - 1) -> $i {
      if ( $word.substr( $i , 1 ) eq $char ) {
	 $total++ ;
      }
   }
   return $total ;
}

say "Enter a string with some bars!" ;
my $line = $*IN.get ;
if ( count( $line , "|" ) <= 1 ) {
   my $result = count( $line , "*" ) ;
   say $result ;
}
else {
   my $barFound = False ;
   my $filtered ; #copy with only the characters we are looking for
   for $line.comb -> $c {
      if ( $c ne "|" ) {
	 $filtered ~= $c ;
      }
      else {
#if we haven't found a bar yet we add a new bar
#otherwise we remove everything from the last bar on
	 if ( $barFound ) {
	    my $pos = $filtered.index( "|" ) ;
	    $filtered .= substr( 0 , $pos ) ;
	    $barFound = False ;
	 }
	 else {
	    $filtered ~= "|" ;
	    $barFound = True ;
	 }
      }
   }
   say count( $filtered , "*" ) ;
}
