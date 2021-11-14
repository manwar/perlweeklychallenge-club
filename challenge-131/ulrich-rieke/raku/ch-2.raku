use v6 ;

sub MAIN( ) {
  say "Enter delimiters!" ;
  my $line = $*IN.get ;
  my $delimiters = $line ;
  say "Enter search string!" ;
  $line = $*IN.get ;
  my $searchString = $line ;
  my %openingChars ;
  my %closingChars ;
  my @delimChars = $delimiters.comb ;
  for (0 .. $delimiters.chars - 1 ) -> $i {
      if ( $i %% 2 ) {
    %openingChars{ @delimChars[ $i ]}++ ;
      }
      else {
    %closingChars{ @delimChars[ $i ] }++ ;
      }
  }
  my $firstOutput ;
  my $secondOutput ;
  for (0 .. $searchString.chars - 1 ) -> $pos {
      my $letter = $searchString.substr( $pos , 1 ) ;
      if ( %openingChars{ $letter }:exists ) {
    $firstOutput ~= $letter ;
      }
      if ( %closingChars{ $letter }:exists ) {
    $secondOutput ~= $letter ;
      }
  }
  say $firstOutput ;
  say $secondOutput ;
}
