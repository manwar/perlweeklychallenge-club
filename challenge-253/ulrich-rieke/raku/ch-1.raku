use v6 ;

say "Enter some strings, separated by whitespace!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
say "Enter a separator!" ;
my $sep = $*IN.get ;
my @result ;
for @strings <-> $str {
   if ( $str ~~ /$sep/ ) {
      $str ~~ s:g/$sep/ / ;
      my @parts = $str.words ;
      for @parts -> $p { 
	 @result.push( $p ) ;
      }
   }
   else {
      @result.push( $str ) ;
   }
}
say ( "(" ~ @result.join( ' ' ) ~ ")" ) ;
