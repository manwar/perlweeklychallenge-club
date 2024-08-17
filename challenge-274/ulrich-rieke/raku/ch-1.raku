use v6 ;

sub convert( ($index , $word is copy) ) {
   my $vowels = ('A' , 'E' , 'I' , 'O' , 'U' , 'a' , 'e' , 'i' , 'o' , 'u').Set ;
   my $firstLetter = ($word.comb)[0] ;
   if ( $firstLetter (elem) $vowels ) {
      $word ~= "ma" ;
   }
   else {
      $word = ($word.substr( 1 ) ~ $firstLetter.Str ~ "ma" ) ;
   }
   $word ~= 'a' x ( $index + 1 ) ;
   return $word ;
}

say "Enter a sentence!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @word_indices ;
for (0..@words.elems - 1 ) -> $pos {
   @word_indices.push( ($pos , @words[ $pos ] ) ) ;
}
my @converted = @word_indices.map( { convert( $_ ) } ) ;
say @converted.join( ' ' ) ;
