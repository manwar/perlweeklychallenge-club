use v6 ;

sub isSorted( $str is copy ) {
   my $sorted = $str.comb.sort.join ;
   return $sorted eq $str ;
}

say "Enter some words of equal length separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my $len = @words[0].chars ;
my $wordslen = @words.elems ;
my @transposed ; # array of columnwise transposition of word characters
for (0..$len - 1 ) -> $i { #for every character in a word 
   my $transpo ; #transposed character 
   for (0..$wordslen - 1 ) -> $w { #for every word
      $transpo ~= @words[$w].substr( $i , 1 ) ;
   }
   @transposed.push( $transpo ) ;
}
say @transposed.grep( {not isSorted( $_ )} ).elems ;
