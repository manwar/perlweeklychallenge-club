use v6 ;

say "Enter a term consisting of English letters only!" ;
my $term = $*IN.get ;
my $changed ;
for $term.comb -> $letter {
   if ( $letter ~~ /<[a..z]>/ ) {
      $changed ~= $letter.uc ;
   }
   else {
      $changed ~= $letter.lc ;
   }
}
say $changed ;
