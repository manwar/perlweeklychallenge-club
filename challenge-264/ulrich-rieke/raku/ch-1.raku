use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my @uppers = $word.comb.grep( { $_ ~~ /<upper>/ } ) ;
my @selected ;
for @uppers -> $aChar {
   my $lower = ($aChar.ord + 32).chr ;
   if ( $word ~~ /$lower/ ) {
      @selected.push( $aChar ) ;
   }
}
if ( @selected ) {
   my @sorted = @selected.sort ;
   say @sorted[*-1] ;
}
else {
   say "''" ;
}
