use v6 ;

sub find_subarray_sum( @array , $l is copy ) {
   if ( $l == @array.elems || $l == 1 ) {
      return [+] @array ;
   }
   else {
      my $len = @array.elems ;
      my $total = 0 ;
      for (0..$len - $l ) -> $start {
	 my $sum = [+] @array[$start .. $start + $l - 1] ;
	 $total += $sum ;
      }
      return $total ;
   }
}

say "Enter some positive integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @sums ;
my @lengths = (1..@numbers.elems ) ;
for @lengths -> $len {
   unless ( $len %% 2 ) {
      @sums.push(find_subarray_sum( @numbers , $len ) ) ;
   }
}
say [+] @sums ;
