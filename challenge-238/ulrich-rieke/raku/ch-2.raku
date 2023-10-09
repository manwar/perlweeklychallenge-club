use v6 ;

sub decompose( $number is copy ) {
   my @digits ;
   while ( $number != 0 ) {
      my $remainder = $number % 10 ;
      @digits.push( $remainder ) ;
      $number div= 10 ;
   }
   return @digits ;
}

sub find_steps( $number is copy ) {
   if ( $number < 10 ) {
      return 0 ;
   }
   else {
      my $steps = 1 ;
      my @digits = decompose( $number ) ;
      my $product = [*] @digits ;
      while ( $product > 9 ) {
	 $steps++ ;
	 @digits = decompose( $product ) ;
	 $product = [*] @digits ;
      }
      return $steps ;
   }
}

sub my_sorter( $firstNum , $secondNum ) {
   my $steps1 = find_steps( $firstNum ) ;
   my $steps2 = find_steps( $secondNum ) ;
   if ( $steps1 != $steps2 ) {
      if ( $steps1 < $steps2 ) {
	 return Order::Less ;
      }
      else {
	 return Order::More ;
      }
   }
   else {
      if ( $firstNum < $secondNum ) {
	 return Order::Less ;
      }
      else {
	 return Order::More ;
      }
   }
}

say "Enter some positive integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $sorted = @numbers.sort: &my_sorter ;
say "(" ~ $sorted.join( ',' ) ~ ")" ;
