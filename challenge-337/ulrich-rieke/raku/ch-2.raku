use v6 ;

say "Enter the number of rows and columns of a matrix!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter some pairs in brackets, separated by a ,!" ;
$line = $*IN.get ;
my @pairs ;
my @parts = $line.split( /\] \s* ',' \s*\[/ ) ;
for @parts -> $pair {
   if ($pair ~~ /(\d+)\s* ',' \s* (\d+) / ) {
      my $numberpair = [+$0 , +$1] ;
      @pairs.push( $numberpair ) ;
   }
}
my @matrix ;
for (0..@numbers[0] - 1) -> $r {
   @matrix.push( (0 xx @numbers[1]).Array ) ;
}
for @pairs -> $p {
   for (0..@numbers[1] - 1) -> $c {
      @matrix[$p[0]][$c]++ ;
   }
   for (0..@numbers[0] - 1) -> $r {
      @matrix[$r][$p[1]]++ ;
   }
}
my $sum = 0 ;
for (0..@numbers[0] - 1) -> $r {
   for (0..@numbers[1] - 1) -> $c {
      if ( not (@matrix[$r][$c] %% 2 )) {
	 $sum++ ;
      }
   }
}
$sum.say ;
