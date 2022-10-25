use v6 ;

say "Enter some positive integers, separated by a blank!" ;
say "As last integer, enter a positive integer as divisor!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ) ;
my $k = @numbers[*-1] ;
my $len = @numbers.elems ;
my $count = 0 ;
for (0 .. $len - 3 ) -> $i {
  for ( $i + 1 .. $len - 2 ) -> $j {
      if (@numbers[ $i ] + @numbers[ $j ] ) %% $k {
    $count++ ;
      }
  }
}
say $count ;
