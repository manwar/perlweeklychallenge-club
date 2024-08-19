use v6 ;

say "Enter some positive integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $result = True  ;
for (0..@numbers.elems - 1) -> $i {
   if (( @numbers.grep( {$_ == $i} ).elems) != @numbers[ $i ]  ) {
      $result = False ;
   }
}
say $result ;
