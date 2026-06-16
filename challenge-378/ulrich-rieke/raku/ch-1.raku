use v6 ;

say "Enter an alphanumberic string!" ;
my $line = $*IN.get ;
my %digits ;
for ( $line.comb ) -> $letter {
   if ( $letter ~~ /\d/ ) {
      %digits{$letter}++ ;
   }
}
my $len = %digits.keys.elems ;
if ( $len == 0 || $len == 1 ) {
   say -1 ;
}
else {
   my @sorted = %digits.keys.sort( {$^b <=> $^a} ) ;
   say @sorted[1] ;
}
