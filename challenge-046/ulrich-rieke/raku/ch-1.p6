use v6 ;

sub decode( *@words ) {
  my $len = @words[0].chars ;
  my $decoded ;
  for (0..$len - 1 ) -> $i {
      my %letterfrequency ;
      for @words -> $word {
    %letterfrequency{ $word.substr( $i , 1 ) }++ ;
      }
      my @sorted = %letterfrequency.keys.sort( { %letterfrequency{$^b}
        <=> %letterfrequency{$^a} } ) ;
      $decoded ~= @sorted[ 0 ] ;
  }
  return $decoded ;
}

my @strings = ("Hx14!" , "ce-lo" , "ze6lg" , "HWlvR" , "q9m#o" ) ;
say decode( @strings ) ;
#'$' has to be quoted within a string in order to avoid interpolation
@strings = ("P+2l!ato" , "1e80R\$4u" , "5-r]+a>/" , "Pxwlb3k\\" ,
      "2e35R8yu" , "<!r^()k0" ) ;
say decode( @strings ) ;
