use v6 ;

sub count( $word , $letter ) {
   my @letters = $word.comb ;
   return @letters.grep( {$_ eq $letter} ).elems ;
}

say "Enter some words, separated by spaces!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @sets = @words.map( {$_.comb.Set} ) ;#find unique characters in every word
my $allCommon = [(&)] @sets ;#common letters in all words
my @result ;
for $allCommon.keys.sort -> $letter {
   my $mini = @words.map( { count( $_ , $letter ) } ).min ;
   for (0..$mini - 1 ) {
      @result.push( $letter ) ;
   }
}
say "(" ~ @result.join( ',' ) ~ ")" ;
