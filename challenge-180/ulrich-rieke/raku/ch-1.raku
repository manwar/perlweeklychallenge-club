use v6 ;

say "Enter a sentence!" ;
my $line = $*IN.get ;
my %letterFrequencies ;
for (0 .. $line.chars - 1 ) -> $i {
  my $letter = $line.substr( $i , 1 ) ;
  if ( $letter ne " " ) {
      %letterFrequencies{$letter}++ ;
  }
}
my @uniques = %letterFrequencies.keys.grep( { %letterFrequencies{$_} == 1 } ) ;
my $minimumFound = $line.chars - 1 ;
for @uniques -> $letter {
  my $found = $line.index( $letter ) ;
  if ( $found < $minimumFound ) {
      $minimumFound = $found ;
  }
}
say $minimumFound ;
