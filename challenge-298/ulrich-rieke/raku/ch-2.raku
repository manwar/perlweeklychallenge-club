use v6 ;

sub find( @array , $elt ) {
   my $pos = 0 ;
   while ( @array[$pos] != $elt ) {
      $pos++ ;
   }
   return $pos ;
}

say "Enter some integers , with every first , third and so on integer unique!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my $current = 0 ;
my @pairs ;
while ( $current < $len - 1 ) {
   my @curPair = ( @numbers[$current] , @numbers[$current + 1] ) ;
   @pairs.push( @curPair ) ;
   $current += 2 ;
}
my @solution ;
for (0..@pairs.elems - 1 ) -> $i {
   my @selected = @pairs.grep( {$_[0] >= @pairs[$i][1]} ) ;
   my @starts = @selected.map( {$_[0]} ) ;
   if ( @starts ) {
      my $mini = @starts.min ;
      my @first_elements = @pairs.map( {$_[0]} ) ;
      my $pos = find(@first_elements , $mini ) ;
      @solution.push( $pos ) ;
   }
   else {
      @solution.push( -1 ) ;
   }
}
say "(" ~ @solution.join( ',' ) ~ ")" ;
