use v6 ;

sub to_lower_case( $word ) {
   my @letters = $word.comb ;
   my @revised ;
   for @letters -> $letter {
      if ( ord( $letter ) > 64 && ord( $letter ) < 91 ) {
         @revised.push( chr( ord( $letter ) + 32 ) ) ;
      }
      else {
         @revised.push( $letter ) ;
      }
   }
   return @revised.join ;
}

say "Enter a sentence!" ;
my $line = $*IN.get ;
say $line.words.sort( &to_lower_case).join( ' ' ) ;
