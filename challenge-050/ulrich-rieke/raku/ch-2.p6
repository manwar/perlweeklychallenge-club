use v6 ;

sub findNoble( @randomNumbers ) {
  my @sorted = @randomNumbers.unique.sort ;
  my $len = @sorted.elems ;
  my @nobles ;
  for ( 0..$len - 1 ) -> $current {
      if ( @sorted[ $current ] == $len - 1 - $current ) {
    @nobles.push( @sorted[ $current ] ) ;
      }
  }
  return @nobles ;
}

my $howmany = (1..50).roll ;
my @randoms = (1..50).roll( $howmany ) ;
.say for findNoble( @randoms ) ;
