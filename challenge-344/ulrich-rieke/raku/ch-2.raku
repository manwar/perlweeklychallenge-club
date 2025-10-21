use v6 ;

sub findNeighbours( $len , @array ) {
   my $alen = @array.elems ;
   my @neighbours ;
   for (0..$alen - $len) -> $start {
      my @row ;
      for ( $start..$start + $len - 1 ) -> $i {
	 @row.push( @array[$i] ) ;
      }
      @neighbours.push( @row ) ;
   }
   return @neighbours ;
}

#stringify @array for comparison!
sub convert( @array ) {
   my $word ;
   if ( @array.elems == 1 ) {
      $word ~= (~@array[0] ~ '|') ;
   }
   else {
      $word = @array.join( '|' ) ;
   }
   return $word ;
}

say "Enter some integers, <return> to end!" ;
my $line = $*IN.get ;
my @source ;
while ( $line ) {
   my @row = $line.words.map( {.Int} ) ;
   @source.push( @row ) ;
   say "Enter some integers, <return> to end!" ;
   $line = $*IN.get ;
}
say "Enter some integers for the target!" ;
my $targetline = $*IN.get ;
my @target = $targetline.words.map( {.Int} ) ;
my $sourceelements = 0 ;
for @source -> @el {
   $sourceelements += @el.elems ;
}
if ( $sourceelements != @target.elems ) {
   say "False" ;
}
else {
   my @results ;
   for @source -> @el {
      my @neighbours = findNeighbours(@el.elems , @target ) ;
      my %targethash ;
      for @neighbours -> @found {
	 %targethash{convert( @found )}++ ;
      }
      if ( %targethash{ convert( @el ) }:exists ) {
	 @results.push( 1 ) ;
      }
      else {
	 @results.push( 0 ) ;
      }
   }
   say so 1 == @results.all ;
}
