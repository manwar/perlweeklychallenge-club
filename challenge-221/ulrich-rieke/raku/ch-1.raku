use v6 ;

sub lettercount( $word ) {
  my %wordHash ;
  for $word.comb -> $letter {
      %wordHash{$letter}++ ;
  }
  return %wordHash ;
}

sub condition( $aWord, %compCount ) {
  my %wordHash = lettercount( $aWord ) ;
  for %wordHash.keys -> $k {
      if not ( %compCount{$k}:exists && %compCount{ $k } >=
        %wordHash{ $k } ) {
    return False ;
      }
  }
  return True ;
}

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say "Enter a word to take the letters from!" ;
my $comparator = $*IN.get ;
my %compHash ;
for $comparator.comb -> $letter {
  %compHash{$letter}++ ;
}
my @selected = @words.grep( {condition( $_ , %compHash )} ) ;
if ( @selected ) {
  my @lengths = @selected.map( {$_.chars} ) ;
  say [+] @lengths ;
}
else {
  say 0 ;
}
