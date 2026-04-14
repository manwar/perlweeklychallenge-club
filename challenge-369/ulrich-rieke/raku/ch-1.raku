use v6 ;
sub tagString( $word is copy ) {
   $word .= trim-leading;
   $word .= trim-trailing ;
   my @currentWords = $word.words ;
   @currentWords.map( { $_ ~~ s:g/<-[a..zA..Z]>// } ) ;
   my $output = "#" ;
   $output ~= @currentWords[0].lc ;
   for (1 .. @currentWords.elems - 1) -> $pos {
      my $current = @currentWords[$pos] ;
      if ( $current ) {
         $output ~= $current.substr( 0 , 1 ).tc ;
         $output ~= $current.substr( 1 ).lc ;
      }
   }
   if $output.chars > 100 {
      $output = $output.substr( 0 , 100 ) ;
   }
   return $output ;
}

say "Enter a sentence!" ;
my $line = $*IN.get ;
say tagString( $line ) ;
