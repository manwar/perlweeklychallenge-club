use v6 ;

sub isPalindrome( Int $number is copy ) {
   my $numberstring = ~$number ;
   return $numberstring eq $numberstring.comb.reverse.join ;
}

say "Enter a number!" ;
my $num = $*IN.get ;
my Int $number = $num.Int ;
my Int $current = $number ;
repeat {
   $current--
} until ( isPalindrome( $current ) ) ;

my $minusnum = ~$current ;
my $minusdiff = ( $number - $current ).abs ;
$current = $number ;
repeat {
   $current++ ;
} until ( isPalindrome( $current ) ) ;
my $plusnum = ~$current ;
my $plusdiff = ( $number - $current ).abs ;
if ( $plusdiff == $minusdiff ) {
   say $minusnum ;
}
else {
   if ( $plusdiff < $minusdiff ) {
      say $plusnum ;
   }
   else {
      say $minusnum ;
   }
}
