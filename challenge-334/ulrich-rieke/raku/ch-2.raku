use v6 ;

sub isValid( $firstpair , $secondpair ) {
   return $firstpair[0] == $secondpair[0] || $firstpair[1] == 
      $secondpair[1] ;
}

sub manhattan( $firstpair , $secondpair ) {
   return  ($firstpair[0] - $secondpair[0]).abs + ( $firstpair[1] - 
	 $secondpair[1]).abs ;
}

say "Enter 2 integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $origin = [@numbers[0] , @numbers[1]] ;
say "Enter some points in brackets separated by blanks with commas!" ;
$line = $*IN.get ;
my @pairs ;
my @parts = $line.split( /\] ',' \s+\[/ ) ;
for @parts -> $pair {
   if ($pair ~~ /(\d+)\s* ',' \s* (\d+) / ) {
      my $numberpair = [+$0 , +$1] ;
      @pairs.push( $numberpair ) ;
   }
}
my @zipped ;
for (0..@pairs.elems - 1) -> $i {
   @zipped.push( [ $i , @pairs[$i] ] ) ;
}
my @valids ;
for @zipped -> $pair {
   if ( isValid( $pair[1] , $origin ) ) {
      @valids.push( $pair ) ;
   }
}
my $len = @valids.elems ;
if ( $len == 0 ) {
   say -1 ;
}
elsif ( $len == 1 ) {
   say @valids[0][0] ;
}
else {
   my @distances ;
   for @valids -> $part {
      @distances.push( [$part[0] , manhattan( $part[1] , $origin )] ) ;
   }
   my @sorted = @distances.sort( {$^a[1] <=> $^b[1] || $^a[0] <=> $^b[0] } ) ;
   say @sorted[0][0] ;
}


