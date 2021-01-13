use v6 ;

sub mySwitch( Str $num is copy --> Str ) {
  my $switched = $num.comb.map( { $_ eq "0" ?? "1" !! "0" } ).join ;
  return $switched ;
}

my $current = "0" ;
my $n = 1 ;
while ( $n < 30 ) {
  $current = $current ~ "0" ~ mySwitch( $current.flip ) ;
  $n++ ;
}
say "S30 : $current!" ;
