use v6 ;

say "Enter a string!" ;
my $word = $*IN.get ;
my $reversed ;
my $current = $word.chars ;
if ( $current == 0 ) {
   say '""' ;
}
else {
   $current-- ;
   while ( $current != 0 ) {
      $reversed ~= $word.substr( $current , 1 ) ;
      $current-- ;
   }
   $reversed ~= $word.substr( 0 , 1 ) ;
   say $reversed ;
}
