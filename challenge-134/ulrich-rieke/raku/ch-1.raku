use v6 ;

#we find the first pandigital at base 10 by concatenating 10 as the first
#2 digits with (2 .. 9 ) as the remaining digits in ascending order
#we then add figures consecutively

sub isPandigital( Int $n is copy --> Bool ) {
  my $numberstring = ~$n ;
  return $numberstring.comb.Set.elems == 10 ;
}

my @panDigitals ;
my $start = "10" ~ (2..9).join ;
@panDigitals.push( $start ) ;
my $current = +$start ;
while ( @panDigitals.elems != 5 ) {
  repeat {
      $current++ ;
  } until ( isPandigital( $current )) ;
  @panDigitals.push( $current ) ;
}
say @panDigitals.join(", ") ;
