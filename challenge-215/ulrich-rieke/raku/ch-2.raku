use v6 ;

say "Enter only 1's and 0's in a row, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "How many zeroes would you like to replace?" ;
my $count = $*IN.get.Int ;
my $len = @numbers.elems ;
my $necessary_row ;
if ( $count = 1 ) {
  $necessary_row = 3 ;
}
if ( $count > 1 ) {
  $necessary_row = 3 + $count ;
}
if ( $len < $necessary_row || $len == $necessary_row ) {
  say 0 ;
}
else {
  my @results ;
  for (0..$len - $necessary_row ) -> $i {
      my @removed = @numbers.splice($i , $necessary_row) ;
      if ( @removed.grep( {$_ == 0} ).elems == @removed.elems ) {
    @results.push( True ) ;
      }
      else {
    @results.push( False ) ;
      }
      splice( @numbers , $i , $necessary_row , @removed ) ;
      say @numbers.join( ',' ) ;
  }
  if (any(@results) == True ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
