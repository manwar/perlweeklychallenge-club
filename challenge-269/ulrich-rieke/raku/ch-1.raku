use v6 ;

say "Enter some distinct integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @arr1 ;
my @arr2 ;
my @removed = @numbers.splice( 0 , 1 ) ;
@arr1.push( @removed[ 0 ] ) ;
@removed = @numbers.splice( 0 , 1 ) ;
@arr2.push( @removed[ 0 ] ) ;
while ( @numbers ) {
   @removed = @numbers.splice( 0 , 1 ) ;
   if ( @arr1[*-1] > @arr2[*-1] ) {
      @arr1.push( @removed[0] ) ;
   }
   else {
      @arr2.push( @removed[0] ) ;
   }
}
@arr1.push( @arr2 ) ;
say "(" ~ @arr1.join( ',' ) ~ ")" ;
