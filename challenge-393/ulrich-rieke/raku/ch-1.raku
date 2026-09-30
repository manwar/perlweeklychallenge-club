use v6 ;

say "Enter a positive integer!" ;
my $numberstring = $*IN.get ;
my $number = $numberstring.Int ;
my $total = 0 ;
for (1..$number) -> $a {
   for (1..$number ) -> $b {
      for (1..$number) -> $c {
         if ( $a ** 2 + $b ** 2 == $c ** 2 ) {
            $total++ ;
         }
      }
   }
}
say $total ;
