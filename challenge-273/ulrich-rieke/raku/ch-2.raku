use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my $result = False ;
if ( $word ~~ /b/ ) {
   my $pos = $word.index( 'b' ) ;
   if ($word.substr( $pos + 1 ) !~~ /a/) {
      $result = True ;
   }
}
say $result ;
