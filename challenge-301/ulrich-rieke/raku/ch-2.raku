use v6 ;

#the Hamming distance equals the difference in the number of ones in the 
#bitwise orred number - the bitwise anded number
sub distance( Int $first , Int $second ) {
   my $orred = $first +| $second ;
   my $anded = $first +& $second ;
   my $firstString = $orred.base( 2 ) ;
   my $secondString = $anded.base( 2 ) ;
   my $firstOnes = $firstString.comb.grep( {$_ eq '1'} ).elems ;
   my $secondOnes = $secondString.comb.grep( {$_ eq '1'} ).elems ;
   return ( $firstOnes - $secondOnes ) ;
}

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @combis = @numbers.combinations( 2 ) ;
my $sum = 0 ;
for @combis -> $seq {
   $sum += distance( $seq[0] , $seq[1] ) ;
}
say $sum ;
