use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my @vowels_contained ;
for $word.comb -> $letter {
   if ( $letter ~~ /<[aeiouAEIOU]>/ ) {
      @vowels_contained.push( $letter ) ;
   }
}
my @characters ;
for $word.comb -> $letter {
   if ( $letter ~~ /<[aeiouAEIOU]>/ ) {
      if ( @characters.elems == 0 ) {
	 @characters.push( uc( @vowels_contained.pop( ) )) ;
      }
      else {
	 @characters.push( lc( @vowels_contained.pop( ) ) ) ;
      }
   }
   else {
      @characters.push( $letter ) ;
   }
}
say @characters.join ;
