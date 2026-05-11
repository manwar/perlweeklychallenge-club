use v6 ;

say "Enter a string!" ;
my $word = $*IN.get ;
my %frequencies ;
$word.comb.map( {%frequencies{$_}++} ) ;
if so 1 == %frequencies.values.all {
   say -1 ;
}
else {
   my @most_frequent = %frequencies.keys.grep( {%frequencies{$_} > 1 } ) ;
   my $max_distance = 0 ;
   for @most_frequent -> $letter {
      my $distance = $word.rindex( $letter ) - $word.index( $letter ) - 1 ;
      if ( $distance > $max_distance ) {
         $max_distance = $distance ;
      }
   }
   say $max_distance ;
}

