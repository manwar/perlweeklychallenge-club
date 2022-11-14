use v6 ;

say "Enter a number of integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ).map( {.Int} ) ;
my $maximum = @numbers.max ;
my $retval ;
for @numbers -> $n {
  if ( $maximum != $n && $maximum < 2 * $n ) {
      $retval = -1 ;
      last ;
  }
}
unless $retval {
  $retval = 1 ;
}
say $retval ;
