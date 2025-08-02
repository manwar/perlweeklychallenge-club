use v6 ;

#by formulating the binary numbers of all the numbers from 1 to the number
#of binary strings that were input one can calculate the powerset 
sub createSeedNumbers( $number is copy ) {
   my $startbinary = $number.base( 2 ) ;
   my @binaries ;
   my $len = $startbinary.chars ;
   for (1..$number ) -> $i {
      my $currentBinary = $i.base( 2 ) ;
      my $currentLen = $currentBinary.chars ;
      if ( $currentLen < $len ) {
	 my $diff = $len - $currentLen ;
	 my $firstPart = '0' x $diff ;
	 $currentBinary = $firstPart ~ $currentBinary ;
      }
      @binaries.push( $currentBinary ) ;
   }
   return @binaries ;
}

#to create a powerset we select those elements of the set that are 
#denoted by a 1 in a binary. If a set hat n members , we look at the
#binary representations of all numbers from 1 to 2 ^ n - 1 and pick those
#where there is a 1 in the binary
sub powerset( @array ) {
   my @powSet ;
   my $len = @array.elems ;
   my @seeds = createSeedNumbers( 2 ** $len - 1 ) ;
   for @seeds -> $seed {
      my @currentSet ;
      for (0..$seed.chars - 1) -> $pos {
	 if ( $seed.substr( $pos , 1 ) eq '1' ) {
	    @currentSet.push( @array[$pos] ) ;
	 }
      }
      @powSet.push( @currentSet ) ;
   }
   return @powSet ;
}

#which of the elements of the power set do we regard as valid?
#those with the right number of 0's and 1's!
sub condition( @subarray , $zeroes , $ones ) {
   my $totalstring = [~] @subarray ;
   my $currentZeroes = 0 ;
   my $currentOnes = 0 ;
   for (0..$totalstring.chars - 1 ) -> $pos {
      if ( $totalstring.substr( $pos , 1 ) eq '0' ) {
	 $currentZeroes++ ;
      }
      else {
	 $currentOnes++ ;
      }
   }
   return $currentZeroes == $zeroes && $currentOnes == $ones ;
}

say "Enter some binary strings separated by whitespace!" ;
my $line = $*IN.get ;
my @binary_strings = $line.words ;
say "Enter a positive integer x denoting the number of 0!" ;
my $xs = $*IN.get ;
my $x = +$xs ;
say "Enter a positive integer y denoting the number of 1!" ;
my $ys = $*IN.get ;
my $y = +$ys ;
my @powSet = powerset( @binary_strings ) ;
my @selected = @powSet.grep( {condition( @_ , $x , $y) } ) ;
my $maxsize = 0 ;
for @selected -> @subarray {
   if ( @subarray.elems > $maxsize ) {
      $maxsize = @subarray.elems ;
   }
}
say $maxsize ;
