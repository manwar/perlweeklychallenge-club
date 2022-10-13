use v6 ;

sub makeover( $str is copy ) {
  my $madeover ;
  for ( $str.comb) -> $letter {
      $madeover ~= chr($letter.NFD.list[0]) ;
  }
  return $madeover ;
}

say "Enter a string of possible unicode characters!" ;
my $str = $*IN.get ;
while ( $str !~~ /^(<:Lu + :Lm>|<:Ll + :Lm>)+$/ ) {
  say "Input should contain non-ASCII characters!" ;
  $str = $*IN.get ;
}
say makeover( $str ) ;
