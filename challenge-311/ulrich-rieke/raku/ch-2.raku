use v6 ;

sub digitsum( $number ) {
   my @digits = $number.comb.map( {.Int} ) ;
   return [+] @digits ;
}

say "Enter a string consisting of digits only!" ;
my $numberstring = $*IN.get ;
say "Enter a number less than the length of the numberstring!" ;
my $chunk = $*IN.get ;
my $chunksize = +$chunk ;
#chop number to chunks of $chunksize using method rotor, leave room for
#rest by invoking partial
my @numberparts = $numberstring.comb.rotor( $chunksize , :partial ).map( 
      {$_.join('')} ) ;
my $sum_of_digits ;
@numberparts.map( {$sum_of_digits ~= ~digitsum( $_ )} ) ;
while ( $sum_of_digits.chars > $chunksize ) {
   @numberparts = $sum_of_digits.comb.rotor( $chunksize , :partial ).map( {
	 $_.join('') } ) ;
   $sum_of_digits = "" ;
   @numberparts.map( {$sum_of_digits ~= ~digitsum( $_ ) } ) ;
}
say $sum_of_digits ;
