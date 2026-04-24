use v6 ;

sub isAnagram( $firstWord is copy , $secondWord is copy ) {
   my $firstLetters = $firstWord.comb.Bag ;
   my $secondLetters = $secondWord.comb.Bag ;
   return $secondLetters.kxxv.sort eq $firstLetters.kxxv.sort ;
}

sub isScrambled( $firstWord , $secondWord ) {
   my $len = $firstWord.chars ;
   for (1..$len - 2 ) -> $i {
      if (( isAnagram( $firstWord.substr( 0 , $i ) , $secondWord.substr( 0 , $i )))
          && isAnagram( $firstWord.substr( $i ) , $secondWord.substr( $i ) )) ||
         ( (isAnagram( $firstWord.substr( 0 , $i ) , $secondWord.substr( $i ))) 
           && ( isAnagram( $firstWord.substr( $i ) , $secondWord.substr(0 , $i )))) {
            return True ;
         }
   }
   return False ;
}

say "Enter two strings of equal length!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
say isScrambled( @allWords[0] , @allWords[1] ) ;

