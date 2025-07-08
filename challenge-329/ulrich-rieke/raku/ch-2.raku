use v6 ;

sub isNice( $substring ) {
   my @letters = $substring.comb ;
   for @letters -> $l {
      if ( $l ~~ /<[A..Z]>/ ) {
	 if ( not so $l.lc eq @letters.any ) {
	    return False ;
	 }
      }
      if ( $l ~~ /<[a..z]>/ ) {
	 if ( not so $l.uc eq @letters.any ) {
	    return False ;
	 }
      }
   }
   return True ;
}

say "Enter a string containing only lowercase and uppercase English letters!" ;
my $word = $*IN.get ;
my @substrings ;
my $len = $word.chars ;
for (0..$len - 2) -> $start {
   for ($start + 1 .. $len - 1 ) -> $end {
      my $subst = $word.substr( $start , $end - $start + 1) ;
      @substrings.push( $subst ) ;
   }
}
my @selected = @substrings.grep( {isNice( $_) } ) ;
if ( @selected ) {
   my @sorted = @selected.sort( {$^b.chars <=> $^a.chars} ) ;
   say @sorted[0] ;
}
else {
   say "\"\"" ;
}
