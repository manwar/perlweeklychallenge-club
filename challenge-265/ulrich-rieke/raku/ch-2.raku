use v6 ;

say "Enter an alphanumeric string!" ;
my $word = $*IN.get ;
say "Enter some alphabetic strings!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
my $all_small ;
for $word.comb -> $letter {
   if ( $letter ~~ /<upper>/ ) {
      $all_small ~= $letter.lc ;
   }
   if ( $letter ~~ /<lower>/ ) {
      $all_small ~= $letter ;
   }
}
my $wordBag = $all_small.comb.sort.Bag ;
my @selected ;#for the completing words
for @strings -> $aWord {
   my $aWordBag = $aWord.comb.sort.Bag ; #count the letters in a "bag"
   my $len = $all_small.chars ;
#check whether for every letter in the alphanumeric first word we have
#a bag entry that is at least as much as in the alphanumeric word
#if that is so , the following term must be true
   if ($all_small.comb.grep( {$aWordBag{$_} >= $wordBag{$_} } ).elems
	 == $len ) {
      @selected.push( $aWord ) ;
   }
}
if ( @selected ) {
   my @sorted = @selected.sort( {$^a.chars <=> $^b.chars} ) ;
   say @sorted[0] ;
}
else {
   say " " ;
}
