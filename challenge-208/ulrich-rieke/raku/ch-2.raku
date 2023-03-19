use v6 ;

say "Enter some integers, at most one missing and one duplicate!" ;
say "Separate by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ).sort( { $^a <=> $^b } ) ;
my $len = @numbers.elems ;
my @found ;
for (0..$len - 2 ) -> $i {
  if ( @numbers[ $i + 1 ] == @numbers[ $i ] ) { #duplicate
      @found.push( @numbers[ $i ]  ) ; #duplicate number
      if ( $i == $len - 2 ) {
    @found.push( @numbers[ $i ] + 1 ) ; #missing number , at the end
      }
  }
  if ( @numbers[ $i + 1 ] - @numbers[ $i ] > 1 ) {
      @found.push( @numbers[ $i ] + 1 ) ;
  }
}
if ( @found ) {
  print "(" ;
  print @found.join( ',' ) ;
  say ")" ;
}
else {
  say "-1" ;
}
