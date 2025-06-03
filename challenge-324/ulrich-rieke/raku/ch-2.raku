use v6 ;

#the task is to find the xor-sum for each subset of the powerset of 
#numbers entered. I didn't find a suitable Raku library for that
#so I resorted to creating the binaries of all numbers from 0 to 
#2 ^ ( n - 1 ) where n is the number of elements in the set. 1 means
#element has to be entered , 0 not

sub createSubsetStrings( $n ) {
   my @numberstrings ;
   for (0..2 ** $n - 1 ) -> $number {
      @numberstrings.push( fillUp( $n , $number.base( 2 ) )) ;
   }
   return @numberstrings ;
}

sub fillUp( $number , $string ) {
   my $diff = $number - $string.chars ;
   if ( $diff == 0 ) {
      return $string ;
   }
   else {
      return ('0' x $diff) ~ $string ;
   }
}

sub mySum( @list ) {
   my $sum = 0 ;
   if ( @list.elems == 1 ) {
      $sum = @list[0] ;
   }
   else {
      for @list -> $elt {
	 $sum = $sum +^ $elt ;
      }
   }
   return $sum ;
}

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @selectionStrings = createSubsetStrings( $len ) ;
my @allLists ;
for @selectionStrings -> $str {
   my @pairs = $str.comb Z, @numbers ;
   my @list ;
   @pairs.grep( {$_[0] eq "1"} ).map( { @list.push( $_[1] ) } ) ;
   @allLists.push( @list ) ;
}
say [+] @allLists.map( {mySum( $_ ) } ) ;
