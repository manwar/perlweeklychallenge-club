use v6 ;

say "Enter a number of integers , separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/ ).map( {.Int} ) ;
my $maxPos = 0 ;
my $maximum = @numbers[ 0 ] ;
my %seen ;
%seen{ $maximum }++ ;
for (1 .. @numbers.elems - 1 ) -> $i {
  if ( @numbers[ $i ] > $maximum ) {
      unless %seen{ @numbers[ $i ] }:exists {
    $maximum = @numbers[ $i ] ;
    $maxPos = $i ;
      }
  }
  %seen{ @numbers[ $i ] }++ ;
}
say $maxPos ;
