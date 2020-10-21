use v6 ;

#compute the sum of the array and find a combination of all those
#numbers that add up to half the arraysum. If we flip their signs
#the array sum will be close to 0

sub enterArray( ) {
  my @array ;
  my $line = prompt "Enter an integer ( -1 to end ) : " ;
  while ( $line != -1 ) {
      @array.push( $line ) ;
      $line = prompt "Next number : " ;
  }
  return @array ;
}
my @array = enterArray( ) ;
my $arraysum = [+] @array ;
my $limit = $arraysum div 2 ;
my $firstpart ;
my $secondpart ;
my @smaller = @array.grep( { $_ <= $limit } ) ;
my @sorted = @smaller.sort( { $^a <=> $^b } ) ;
if ( @sorted[*-1] == $limit ) {
  $firstpart = $limit ;
}
else {
  my $len = @smaller.elems ;
  if ( $len == 2 ) {
      $firstpart = [+] @smaller ;
  }
  else {
      my @combisums ;
      for ( 2..$len) -> $i {
    for ( @smaller.combinations( $i )) -> $seq {
        @combisums.push( sum $seq ) ;
    }
      }
      my @sorted = @combisums.sort( { $^a <=> $^b } ) ;
      $firstpart = @sorted.first: * <= $limit ;
  }
}
$secondpart = $arraysum - $firstpart ;
say "{ $secondpart - $firstpart }" ;
