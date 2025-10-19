use v6 ;

say "Enter a string consisting of 0 and 1 only!" ;
my $word = $*IN.get ;
my $len = $word.chars ;
my @subsums ;
for (1..$len - 1 ) -> $pos {
   my @left = $word.substr( 0 , $pos ).comb ;
   my $zeroes = @left.grep( {$_ eq '0'} ).elems ;
   my @right = $word.substr( $pos ).comb ;
   my $ones = @right.grep( {$_ eq '1'} ).elems ;
   @subsums.push( $zeroes + $ones ) ;
}
say @subsums.max ;
