use v6 ;

say "Enter a sentence!" ;
my $sentence = $*IN.get ;
say "Enter a word in the sentence!" ;
my $first = $*IN.get ;
say "Enter a word that follows the first word!" ;
my $second = $*IN.get ;
my @result ;
my @allWords = $sentence.words ;
my $len = @allWords.elems ;
my $pos = 0 ;
while ( $pos < $len ) {
   if ( @allWords[$pos] eq $second ) {
      @result.push( @allWords[$pos + 1] ) ;
   }
   $pos++ ;
}
say '(' ~ @result.unique.join(',') ~ ')' ;
