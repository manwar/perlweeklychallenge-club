use v6 ;

sub MAIN( Str $A , Str $B , Str $C) {
  my $lenA = $A.chars ;
  my $lenB = $B.chars ;
  my $interleavedA ;
  my $interleavedB ;
  if ( $lenA == $lenB ) {
      $interleavedA = ($A.comb Z~ $B.comb).join ;
      $interleavedB = ($B.comb Z~ $A.comb).join ;
  }
  if ( $lenA > $lenB ) {
      $interleavedA = ($A.substr(0, $lenB) Z~ $B.comb).join ~
    $A.substr($lenB, $lenA - $lenB) ;
      $interleavedB = ($B.comb Z~ $A.substr(0, $lenB) ).join ~
        $A.substr($lenB, $lenA - $lenB) ;
  }
  if ( $lenB > $lenA ) {
      $interleavedA = ($B.substr(0, $lenA) Z~ $A.comb).join ~
        $A.substr($lenA, $lenB - $lenA) ;
      $interleavedB = ($A.comb Z~ $B.substr(0, $lenA) ).join ~
        $A.substr($lenA, $lenB - $lenA) ;
  }
  if ( $interleavedA eq $C or $interleavedB eq $C ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
