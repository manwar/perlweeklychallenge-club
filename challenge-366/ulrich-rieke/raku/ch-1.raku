use v6 ;

say "Enter a sentence with some words separated by blanks!" ;
my $line = $*IN.get ;
my @allWords ;
if ( $line ~~ /^\s/ ) {
  @allWords.push( "" ) ;
  $line.subst(/^\s/) ;
  for $line.words -> $w {
     @allWords.push( $w ) ;
  }
}
else {
   @allWords = $line.words ;
}
say "Enter a word!" ;
my $word = $*IN.get ;
say @allWords.grep( { $word.substr( 0 , $_.chars ) eq $_ } ).elems ;
