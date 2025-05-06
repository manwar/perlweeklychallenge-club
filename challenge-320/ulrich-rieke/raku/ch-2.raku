use v6 ;

sub digitsum( $number is copy ) {
   my $sum = 0 ;
   while ( $number != 0 ) {
      $sum += $number % 10 ;
      $number div= 10 ;
   }
   return $sum ;
}

say "Enter some positive integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $numbersum = [+] @numbers ;
my $all_digit_sum = [+] @numbers.map( {digitsum( $_ )} ) ;
say ($numbersum - $all_digit_sum).abs ;
