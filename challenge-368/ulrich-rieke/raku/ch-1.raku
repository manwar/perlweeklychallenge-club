use v6 ;

say "Enter a number string!" ;
my $number = $*IN.get ;
say "Enter a character!" ;
my $char = $*IN.get ;
if ( $number ~~ /^$char (.)/ && $char < +$0 ) {
   $number ~~ s/^.// ;
}
else {
   my $pos = $number.rindex( $char ) ;
   if ~$pos ~~ /^\d$/ {
      $number = $number.substr( 0 , $pos ) ~ $number.substr( $pos + 1 ) ;
   }
}
say $number ;
