use v6 ;

#translate a given word into a word in the ordinary alphabet by mapping
#the place a letter was found in the alternative alphabet to the "normal"
#one
sub translate( $word , @alphabet ) {
   my $translated ;
   my $alternative = join( '' , @alphabet ) ;
   for ( $word.comb ) -> $letter {
      my $pos = $alternative.index( $letter ) ;
      $translated ~= chr( $pos + 97 ) ;
   }
   return $translated ;
}

say "Enter some strings separated by whitespace!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say "Enter a complete alphabet separated by spaces!" ;
my $alphaline = $*IN.get ;
my @letters = $alphaline.words ;
my %translation ;
@words.map( { %translation{$_} = translate( $_ , @letters ) } ) ;
my @sorted = %translation.keys.sort( {%translation{$^a} leg
      %translation{$^b} } ) ;
say '(' ~ join( ',' , @sorted ) ~ ')' ;
