use v6 ;

say "Enter a positive integer!" ;
my $line = $*IN.get ;
while ( $line !~~ /^\d+$/ ) {
  say "Enter a positive integer, re-enter!" ;
  $line = $*IN.get ;
}
my $binaryStr = $line.Int.base( 2 ) ;
my @digits = $binaryStr.comb ;
for @digits <-> $digit {
  if ( $digit == 0 ) {
      $digit = 1 ;
  }
  else {
      $digit = 0 ;
  }
}
say @digits.join.parse-base( 2 ) ;
