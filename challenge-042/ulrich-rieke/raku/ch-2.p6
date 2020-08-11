use v6 ;

sub validateBrackets( Str $term --> Bool) {
  if ( $term ~~ /^ ')' | '(' $/ ) {
      return False ;
  }
  return countLetter( $term , '(') == countLetter( $term , ')') ;
}

sub countLetter( Str $term , Str $letter --> Int) {
  my $count = 0 ;
  for ( $term.comb) -> $let {
      if ( $let eq $letter ) {
    $count++ ;
      }
  }
  return $count ;
}

sub generateString( Int $length --> Str ) {
  return ( '(' , ')' ).roll( $length ).join.Str ;
}

my @generated ;
for (1..10) -> $i {
  @generated.push( generateString( $i ) ) ;
}
for @generated -> $bracketstring {
  print "$bracketstring-" ;
  say validateBrackets( $bracketstring ) ?? "OK" !! "NOT OK" ;
}
