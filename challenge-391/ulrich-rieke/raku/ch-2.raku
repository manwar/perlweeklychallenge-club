use v6 ;

say "Enter an even number of positive integers!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @pairs ;
my $pos = 0 ;
while ( $pos < $len - 1 ) {
   my @pair = ( @numbers[$pos] , @numbers[$pos + 1] ) ;
   @pairs.push( @pair ) ;
   $pos += 2 ;
}
@pairs .= sort( {$^a[0] leg $^b[0]} ) ;
my @selected ;
@selected.push( @pairs[0] ) ;
for (1..@pairs.elems - 1) -> $i {
   if (@pairs[$i][0] > @selected[*-1][0] &&
      @pairs[$i][1] > @selected[*-1][1] ) {
      @selected.push( @pairs[$i] ) ;
   }
}
say @selected.elems ;

