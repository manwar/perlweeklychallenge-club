use v6 ;

sub isSorted ( $aWord is copy ) {
   my $compare = $aWord ;
   return ( $aWord.comb.sort( {$^a cmp $^b} ).join eq $compare || 
	 $aWord.comb.sort( {$^b cmp $^a} ).join eq $compare ) ;
}

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
say $line.words.grep( {not isSorted( $_ )} ).elems ;
