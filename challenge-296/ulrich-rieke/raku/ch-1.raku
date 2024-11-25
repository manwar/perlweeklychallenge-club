use v6 ;

sub compress( $string is copy ) {
   my $compressed ;
   my $current ;
   my @terms ;
   my $last_char = $string.substr( 0 , 1 ) ;
   $current = $last_char ;
   my $len = $string.chars ;
   for (1..$len - 1 ) -> $i {
      my $next_char = $string.substr( $i , 1 ) ;
      if ( $next_char eq $last_char ) {
	 $current ~= $next_char ;
      }
      else {
	 @terms.push( $current ) ;
	 $current = $next_char ;
	 $last_char = $next_char ;
      }
   }
   @terms.push( $current ) ;
   for (@terms) -> $elt {
      my $ct = $elt.chars ;
      if ( $ct > 1 ) {
	 $compressed ~= ~$ct ;
	 $compressed ~= $elt.substr( 0 , 1 ) ;
      }
      else {
	 $compressed ~= $elt.substr( 0 , 1 ) ;
      }
   }
   return $compressed ;
}

sub decompress( $compressed is copy) {
   my $decompressed ;
   my $pos = 0 ;
   my $len = $compressed.chars ;
   while ( $pos != $len ) {
      my $letter = $compressed.substr( $pos , 1 ) ;
      if ( $letter ~~ /\d/ ) {
	 my $num = +$letter ;
	 $pos++ ;
	 my $nextLetter = $compressed.substr( $pos , 1 ) ;
	 for (0..$num - 1 ) {
	    $decompressed ~= $nextLetter ;
	 }
      }
      else {
	 $decompressed ~= $letter ;
      }
      $pos++ ;
   }
   return $decompressed ;
}

say "Enter a word!" ;
my $word = $*IN.get ;
my $compressed = compress( $word ) ;
say "$word compressed : $compressed!" ;
my $decompressed = decompress( $compressed ) ;
say "and decompressed again : $decompressed" ;
