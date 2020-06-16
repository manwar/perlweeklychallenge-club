use v6 ;

sub digitSum( Int $n is copy ) {
  return [+] $n.comb.map( {.Int} ) ;
}

sub MAIN( Int $N , Int $S ) {
  my $lowest = ("1" ~ "0" x ( $N - 1 )).Int ;
  my $highest = ("1" ~ "0" x $N).Int ;
  .say for ($lowest...^$highest).grep( { digitSum( $_ ) == $S } ) ;
}
