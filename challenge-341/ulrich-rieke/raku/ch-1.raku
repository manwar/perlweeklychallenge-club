use v6 ;

sub condition( $word , $letterset ) {
   for $word.comb -> $letter {
      if ( $letter (elem) $letterset ) {
	 return False ;
      }
   }
   return True ;
}

say "Enter a sentence with English letters only!" ;
my $sentence = $*IN.get ;
my @words = $sentence.words ;
say "Enter some letters separated by whitespace!" ;
my $line = $*IN.get ;
my @letters = $line.words ;
my $forbidden = @letters.Set ;
say @words.grep( {condition( $_ , $forbidden)} ).elems ;
