use v6 ;

say "Enter some integers, separated by spaces!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my $count = 0 ;
for (0..$len - 2) -> $pos {
   if ( @numbers[ $pos + 1 ] > @numbers[ $pos ] ) {
      $count++ ;
   }
}
#if $len is the number of elements we can form $len - 1 neighbouring pairs
#that means that in order to fulfill the condition all neighbouring pairs 
#bar 1 must be strictly increasing
my $pairnumber = $len - 1 ;
if ( $count == $pairnumber - 1 ) {
   say "true" ;
}
else {
   say "false" ;
}
