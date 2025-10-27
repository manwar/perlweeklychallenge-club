use v6 ;

sub decompose( $number is copy ) {
   my @digits ;
   while ( $number != 0 ) {
      @digits.push( $number % 10 ) ;
      $number div= 10 ;
   }
   my @result = @digits.reverse ;
   return @result ;
}

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter an integer!" ;
$line = $*IN.get ;
my $x = +$line ;
#the task amounts to interpreting the array as an integer number 
#with the numbers as digits and adding this number to $x , decomposing
#the result thereafter
my $total = 0 ;
my @digits = @numbers.reverse ;
my $pos = 0 ;
for @digits -> $digit {
   $total += $digit * 10 ** $pos ;
   $pos++ ;
}
my $result = $total + $x ;
my @resultArray = decompose( $result ) ;
say '(' ~ @resultArray.join( ',' ) ~ ')' ;

