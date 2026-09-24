use v6 ;

sub isPalindrome( $word ) {
   return $word.comb.reverse.join('') eq $word ;
}

say "Enter a string!" ;
my $word = $*IN.get ;
if ( isPalindrome( $word ) ) {
   say $word ;
}
else {
#in any case , the first letter in itself is a palindrome
#so , starting from the second letter , we see if any of the resulting
#substrings is a palindrome. We mark the rightmost end of the last palindrome
#if any, and prepend the rest of the string
   my $maxi = 1 ;
   my $len = $word.chars ;
   for (2..$len - 1) -> $howmany {
      if ( isPalindrome( $word.substr( 0 , $howmany ) )) {
         if ( $howmany - 1 > $maxi ) {
            $maxi = $howmany - 1 ;
         }
      }
   }
   my $rest ;
   if ( $maxi == 1 ) {
      $rest = $word.substr( $maxi ) ;
   }
   else {
      $rest = $word.substr( $maxi + 1 ) ;
   }
   my $to_be_prepended = $rest.comb.reverse.join ;
   say $to_be_prepended ~ $word ;
}
