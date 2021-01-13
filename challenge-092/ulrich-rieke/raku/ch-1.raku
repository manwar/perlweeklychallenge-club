use v6 ;

sub MAIN(Str $A , Str $B ) {
  if ( $A.chars != $B.chars ) {
      say 0 ;
  }
  else {
      my $output ;
      my $len = $A.chars ;
      my %letterhash ;
      for (0 .. $len - 1 ) -> $i {
    %letterhash{ $A.substr( $i , 1 ) } = $B.substr( $i , 1 ) ;
      }
      if %letterhash.keys.elems == %letterhash.values.unique.elems {
    $output = 1 ;
      }
      else {
    $output = 0 ;
      }
      say $output ;
  }
}
