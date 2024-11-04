use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @sorted = @numbers.sort( {$^a <=> $^b} ) ;
my $len = @numbers.elems ;
my @lengths ;
my $run = 1 ;
my $i = 1 ;
while ( $i < $len ) {
   if ( @sorted[$i] - @sorted[$i - 1] == 1 ) {
      $run++ ;
   }
   else {
      @lengths.push( $run ) ;
      $run = 1 ;
   }
   $i++ ;
}
@lengths.push( $run ) ;
my $maximum = @lengths.max ;
if ( $maximum == 1 ) {
   say -1 ;
}
else {
   $maximum.say ;
}
