use v6 ;

my @less_than_ten = ( "one" , "two" , "three" , "four" , "five" ,
      "six" , "seven" , "eight" , "nine" ) ;
my @teens = ("ten" , "twenty" , "thirty" , "forty" , "fifty" ,
      "sixty" , "seventy" , "eighty" , "ninety" , "hundred" ) ;
my @ebanNumbers ;
for (0 .. @less_than_ten.elems - 1 )  -> $i {
  if (@less_than_ten[ $i ] !~~ /e/) {
      @ebanNumbers.push( $i + 1 ) ;
  }
}
for (0 .. @teens.elems - 1 ) -> $i {
  if ( @teens[$i] ~~ /e/ ) {
      next ;
  }
  else {
      @ebanNumbers.push( ($i + 1 ) * 10 ) ;
      for (0 .. @less_than_ten.elems - 1 ) -> $j {
    if ( @less_than_ten[ $j ] !~~ /e/ ) {
        @ebanNumbers.push( ($i + 1) * 10 + ( $j + 1) ) ;
    }
      }
  }
}
say @ebanNumbers ;
