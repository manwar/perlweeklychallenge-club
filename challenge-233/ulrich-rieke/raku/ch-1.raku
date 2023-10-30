use v6 ;

#how many pairs can be formed if $n is the number of words with the same
#letters ?
sub pairs( $n is copy ) {
   my $result ;
   if ( $n == 0 || $n == 1 ) {
      $result = 0 ;
   }
   if ( $n == 2 ) {
      $result = 1 ;
   }
   if ( $n > 2 ) {
      $result = findCombinations( $n ) ;
   }
   return $result ;
}

#if $n is greater than 2 then the number of combinations is
#$n!/ (($n - 2 )! * 2)
sub findCombinations( $num is copy ) {
   my $numerator = [*](1..$num) ;
   my $denom = [*]( 1..($num - 2)) ;
   return $numerator div ( $denom * 2 ) ;
}

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @letters_in_word = @words.map( {$_.comb.unique.sort} ) ;#unique letters
my %frequencies ;
for @letters_in_word -> $word {
   %frequencies{ $word }++ ;#find the number of unique combination per combi
}
my $pairnumber = 0 ;
for %frequencies.values -> $v {
   $pairnumber += pairs( $v ) ;
}
say $pairnumber ;
