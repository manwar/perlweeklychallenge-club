use v6 ;

say "Enter a word consisting of English letters only!" ;
my $word = $*IN.get ;
my $vowels = "aeiouAEIOU" ;
my %vowelcount ;
my %consocount ;
for $word.comb -> $letter {
   if ( $vowels.index( $letter ) ~~ Int ) {
      %vowelcount{$letter}++ ;
   }
   else {
      %consocount{$letter}++ ;
   }
}
my $vowelmax = 0 ;
my $consomax = 0 ;
if %consocount {
   $consomax += %consocount.values.max ;
}
if %vowelcount {
   $vowelmax += %vowelcount.values.max ;
}
say ( $consomax + $vowelmax ) ;
