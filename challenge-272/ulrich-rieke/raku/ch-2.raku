use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my @numbers = $word.comb.map( {.ord} ) ;
my $sum = 0 ;
for @numbers.rotor( 2 => -1 ) -> $seq {
   my $diff = ($seq[0] - $seq[1]).abs ;
   $sum += $diff ;
}
say $sum ;
