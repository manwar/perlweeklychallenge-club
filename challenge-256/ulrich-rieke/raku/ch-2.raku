use v6 ;

say "Enter two strings, separated by blanks!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
#create zip-wise combinations of letters of the two words, stopping
#when the shorter of the 2 words runs out of characters
my @merged = @strings[0].comb Z~ @strings[1].comb ;
my $len1 = @strings[0].chars ;
my $len2 = @strings[1].chars ;
if ( $len1 != $len2 ) {
   my $smaller = @merged.elems ;#character in the shorter of the two strings
   if ( $len1 < $len2 ) {
      for ($smaller..$len2 - 1 ) -> $pos { #add the remaining characters
	 @merged.push( @strings[1].substr( $pos , 1 ) ) ;
      }
   }
   else {
      for ($smaller..$len1 - 1 ) -> $pos { #add the remaining characters
	 @merged.push( @strings[0].substr( $pos , 1 ) ) ;
      }
   }
}
say @merged.join ;
