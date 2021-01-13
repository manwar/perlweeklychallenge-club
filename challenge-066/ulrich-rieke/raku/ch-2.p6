use v6 ;

sub MAIN( Int $N is copy ) {
  my @results ;
  for (2..$N div 2 ) -> $i {
      my $count = 1 ;
      my $result = $N / $i ;
      while (  $result > 1 ) {
    $count++ ;
    $result /= $i ;
      }
      if ( $result == 1 ) {
    @results.push( "$i^$count" ) ;
      }
  }
  if @results {
      .say for @results ;
  }
  else {
      say 0 ;
  }
}
