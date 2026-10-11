use v6 ;

sub isAlternating( $word ) {
   my $len = $word.chars ;
   my @evenletters ;
   my @oddletters ;
   for (0..$len - 1 ) -> $pos {
      if ( $pos %% 2 ) {
         @evenletters.push( $word.substr( $pos , 1 ) ) ;
      }
      else {
         @oddletters.push( $word.substr( $pos , 1 ) ) ;
      }
   }
   if ( $word.substr( 0 , 1 ) ~~ /<[a e i o u]>/ ) {
      return @evenletters.elems == @evenletters.grep( { $_ ~~
            /<[a e i o u]>/ }).elems && (@oddletters.elems == 
          @oddletters.grep( { $_ !~~ /<[a e i o u]>/ } ).elems) ;
   }
   else {
      return @evenletters.elems == @evenletters.grep( { $_ !~~ 
            /<[a e i o u]>/ } ).elems && ( @oddletters.elems ==
               @oddletters.grep( {$_ ~~ /<[a e i o u]>/} ).elems) ;
   }
}

sub findSubstrings( $word ) {
   my @substrings ;
   my $len = $word.chars ;
   for ( 0..$len - 1) -> $pos {
      for (1..$len - $pos) -> $howmany {
         @substrings.push( $word.substr( $pos , $howmany ) ) ;
      }
   }
   return @substrings ;
}

sub find( $string , @array ) {
   for ( @array ) -> $w {
      if ( $w eq $string ) {
         return True ;
      }
   }
   return False ;
}

say "Enter 3 strings with English alphabetic characters only!" ;
my $line = $*IN.get ;
my ( $first , $second , $third ) = $line.words ;
my @firstsubs = findSubstrings( $first ) ;
my @secondsubs = findSubstrings( $second ) ;
my @thirdsubs = findSubstrings( $third ) ;
my @selection = @firstsubs.grep( { find( $_ , @secondsubs ) && find( $_ , @thirdsubs)
      } ) ;
if ( @selection ) {
   my @solution = @selection.grep( {isAlternating( $_ )} ) ;
   if ( @solution ) {
      @solution .= sort( {$^b.chars <=> $^a.chars} ) ;
      say '(' ~ @solution.grep( {$_.chars == @solution[0].chars} ).join( ',' ) ~ ')'
         ;
   }
   else {
      say "()" ;
   }
}
else {
   say "()" ;
}
