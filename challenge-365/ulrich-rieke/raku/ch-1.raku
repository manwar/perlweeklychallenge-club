use v6 ;

sub digitsum( $number is copy) {
   my @digits ;
   while ( $number != 0 ) {
      @digits.push( $number mod 10 ) ;
      $number div= 10 ;
   }
   return [+] @digits ;
}

sub convert( $word ) {
   my $numberword ;
   for $word.comb -> $letter {
      $numberword ~= ~($letter.ord( ) - 96 ) ;
   }
   return $numberword ;
}

say "Enter a word consisting of lowercase English letters only!" ;
my $word = $*IN.get ;
say "Enter a positive integer!" ;
my $k = $*IN.get ;
my $number = +$k ;
my $result =  digitsum( convert( $word ) ) ;
$number-- ;
while ( $number != 0 ) {
   $result = digitsum( $result ) ;
   $number-- ;
}
$result.say ;


