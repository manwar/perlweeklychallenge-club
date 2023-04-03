use v6 ;

say "Enter some numbers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @allSums ;
my %numberHash ;
@numbers.map( { %numberHash{ $_ }++ }) ;
my @sorted = %numberHash.keys.sort( { $^a <=> $^b } ) ;
for @sorted -> $num {
  my $sum = 0 ;
  if ( %numberHash{ $num - 1}:exists ) {
      $sum += ( $num - 1 ) * %numberHash{ $num - 1 } ;
  }
  $sum += $num * %numberHash{ $num } ;
  if ( %numberHash{ $num + 1 }:exists ) {
      $sum += ( $num + 1 ) * %numberHash{ $num + 1 } ;
  }
  @allSums.push( $sum ) ;
}
say @allSums.max ;
