use v6 ;

sub condition( $word is copy ) {
   my $vowels = set( "aeiou".comb ) ;
   return set( $word.comb ) == $vowels ;
}

say "Enter a string!" ;
my $word = $*IN.get ;
my $len = $word.chars ;
my @solution ;
if ( $len == 5 ) {
   if ( condition( $word )) {
      @solution.push( $word ) ;
   }
}
if ( $len > 5 ) {
   for (0..$len - 5) -> $start {
      for ( $start + 5 .. $len ) -> $end {
         my $substring = $word.substr( $start , $end - $start ) ;
         if ( condition( $substring ) ) {
            @solution.push( $substring ) ;
         }
      }
   }
}
print '(' ;
if @solution {
   print @solution.join( ',' ) ;
}
say ')' ;
