use v6 ;

sub isGapful( Int $num is copy --> Bool ) {
  my $first = $num.Str.comb.Array.shift ;
  my $last = $num.Str.comb.Array.pop ;
  my $divisor = ( $first ~ $last ).Int ;
  return $num %% $divisor ;
}

say (100, 101 ... *).grep( { isGapful( $_ ) } )[^20] ;
