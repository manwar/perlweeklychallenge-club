use v6 ;

#the strategy is : order the list of integers in descending order and put
#the smallest even number at the end

my @digits ;
say "Enter single digits, separate by blank space!" ;
my $line = $*IN.get ;
@digits = $line.split( /\s+/ ) ;
if ( @digits.grep( { not $_ %% 2 } ).elems == @digits.elems ) {
  say "An even digit cannot be formed!" ;
}
else {
  my @sorted = @digits.sort( { $^b <=> $^a } ) ;
  my $len = @sorted.elems ;
  my $i = $len - 1 ;
  unless ( @sorted[ $i ] %% 2 ) {
      $i-- ;
  }
  my $smallestEven = @sorted[ $i ] ;
  @sorted.splice( $i , 1 ) ;
  @sorted.push( $smallestEven) ;
  say @sorted.join ;
}
