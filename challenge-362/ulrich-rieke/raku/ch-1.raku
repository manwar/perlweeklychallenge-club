use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my $result ;
my $howmany = 0 ;
for $word.comb -> $letter {
   for (0..$howmany) {
      $result ~= $letter ;
   }
   $howmany++ ;
}
say $result ;
