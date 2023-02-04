use v6 ;

say "Enter at least 3 integers , separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
while ( $len < 3 ) {
  say "Enter at least 3 numbers!" ;
  $line = $*IN.get ;
  @numbers = $line.words.map( {.Int} ) ;
  $len = @numbers.elems ;
}
my $result = 0 ;
for (0..$len - 3 ) -> $i {
  if @numbers[$i .. $i + 2].grep( { $_ % 2 == 1 }).elems == 3 {
      $result = 1 ;
      last ;
  }
}
say $result ;
