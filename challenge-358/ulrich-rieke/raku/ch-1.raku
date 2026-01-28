use v6 ;

sub findLength( $word ) {
   if ( $word ~~ /^\d+$/ ) {
      return $word.Int ;
   }
   else {
      return $word.chars ;
   }
}

say "Enter some alphanumeric strings separated by blanks!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
say @strings.map( { findLength( $_) } ).max ;
