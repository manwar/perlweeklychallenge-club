use v6 ;

say "Enter an even number of integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
while (not @numbers.elems %% 2 ) {
   say "Enter an even number of integers!" ;
   $line = $*IN.get ;
   @numbers = $line.words.map( {.Int} ) ;
}
my %frequencies ;
for @numbers -> $num {
   %frequencies{ $num }++ ;
}
if (%frequencies.values.grep( { $_ %% 2 } ).elems == %frequencies.values.elems) {
   my @sorted = @numbers.sort( { $^a <=> $^b } ) ;
   my $len = @sorted.elems ;
   my $pos = 0 ;
   my @result ;
   while ( $pos <= $len - 2 ) {
      my $pair = [@sorted[ $pos ] , @sorted[ $pos + 1 ]] ;
      @result.push( $pair ) ;
      $pos += 2 ;
   }
   print "(" ;
   for @result -> $p {
      print  "( $p[0] , $p[1] )" ;
   }
   say ")" ;
}
else {
   say "()" ;
}

