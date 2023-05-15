use v6 ;

sub is_sorted( $aWord ) {
  my $sorted = $aWord.comb.sort.join ;
  return $sorted eq $aWord ;
}

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say @words.grep( { not ( is_sorted( $_ ) ) } ).elems ;
