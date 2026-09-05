use v6 ;

sub isUndulating( @array ) {
   my $number = @array[0] ;
   if (@array.grep( {$_ == $number} ).elems == @array.elems ) {
      return True ;
   }
   elsif ( @array.elems == 2 ) {
      return @array[0] != @array[1] ;
   }
   else {
      my $len = @array.elems ;
      my @differences ;
      for (1..$len - 1) -> $i {
         @differences.push( @array[$i] - @array[$i - 1] ) ;
      }
      my @truths ;
      for (0..@differences.elems - 2) -> $i {
         if ( (@differences[$i] > 0 && @differences[$i + 1] < 0) ||
               (@differences[$i] < 0 && @differences[$i + 1] > 0 )) {
            @truths.push( True ) ;
         }
         else {
            @truths.push( False ) ;
         }
      }
      return @truths.grep( {$_ == True }).elems == @truths.elems ;
   }
}

sub createSubarrays( @array ) {
   my @subarrays ;
   my $len = @array.elems ;
   for (0..$len - 2 ) -> $start {
      for ( $start + 1 ..$len - 1 ) -> $end {
         @subarrays.push( @array[$start..$end] ) ;
      }
   }
   return @subarrays ;
}

sub myLength( @array ) {
   my $number = @array[0] ;
   if ( so $number == @array.all ) {
      return 1 ;
   }
   else {
      return @array.elems ;
   }
}

say "Enter some integers separated by whitespace!" ;
my $numberline = $*IN.get ;
my @numbers = $numberline.words.map( {.Int} ) ;
my @sizes ;
my @subarrays = createSubarrays( @numbers ) ;
for @subarrays -> @innerArray {
   if ( isUndulating( @innerArray ) ) {
      @sizes.push( myLength( @innerArray ) ) ;
   }
}
say @sizes.max ;
