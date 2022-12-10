use v6 ;

sub MAIN( Str $input ) {
  my %letterfrequencies ;
  for $input.comb -> $l {
      %letterfrequencies{$l}++ ;
  }
  my $maximum = %letterfrequencies.values.max ;
  my $minimum = %letterfrequencies.values.min ;
  if ( $maximum == $minimum + 1 && %letterfrequencies.keys.grep( {
        %letterfrequencies{ $_ } == $minimum } ).elems ==
    %letterfrequencies.keys.elems - 1 ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
