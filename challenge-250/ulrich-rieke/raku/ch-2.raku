use v6 ;

sub convert( $aString ) {
   if ( $aString ~~ /\D/ ) {
      return $aString.chars ;
   }
   else {
      return $aString.Int ;
   }
}

say "Enter some strings, separated by blanks!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
my @converted ;
@strings.map( { @converted.push( convert( $_ ) ) } ) ;
say @converted.max ;
