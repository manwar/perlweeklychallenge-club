use v6 ;

say "Enter a list of strings containing only digits and letters!" ;
say "They should be separated by blanks! Enter string by string, <return> to end!" ;
my @strings ;
my $line = $*IN.get ;
while ( $line ) {
  @strings.push( $line ) ;
  $line = $*IN.get ;
}
my @numberlist ;
my @letterlist ;
for @strings -> $word {
  my @currentNumbers ;
  my @currentLetters ;
  for $word.split( /\s/ ) -> $l {
      if ( $l ~~ /<[0..9]>/ ) {
    @currentNumbers.push( $l ) ;
      }
      if ( $l ~~ /<[a..z]>/ ) {
    @currentLetters.push( $l ) ;
      }
  }
  if ( @currentNumbers ) {
      @numberlist.push( '[' ~ @currentNumbers.join( ',' ) ~ ']' ) ;
  }
  if ( @currentLetters ) {
      @letterlist.push( '[' ~ @currentLetters.join( ',' ) ~ ']' ) ;
  }
}
print ('[' ~ @numberlist.join( ',' ) ~ ']' ) ;
print " and " ;
say ('[' ~ @letterlist.join( ',' ) ~ ']' ) ;
