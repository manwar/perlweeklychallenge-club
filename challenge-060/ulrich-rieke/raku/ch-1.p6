use v6 ;

sub number_to_Excel( Int $n --> Str ) {
  if ( $n > 16384 ) {
      return "Error" ;
  }
  if ( $n < 27 ) {
      return ( $n + 64).chr ;
  }
  else {
      my $totals = $n div 26 ;
      my $rest = $n % 26 ;
      return ( "A" xx $totals ).join ~ ( $rest + 64).chr ;
  }
}

sub excel_to_number( Str $column --> Int ) {
  if ( $column.chars == 1 ) {
      return $column.ord - 64 ;
  }
  else {
      my $len = $column.chars ;
      return ( 26 * ( $len - 1 ) + $column.substr( $len - 1 , 1).ord
        - 64 ) ;
  }
}

sub MAIN( *@ARGV ) {
  for @ARGV -> $arg {
      if ( $arg ~~ /\d+/ ) {
    say "$arg : {number_to_Excel( $arg ) } !" ;
      }
      else {
    say "$arg : {excel_to_number( $arg ) } !" ;
      }
  }
}
