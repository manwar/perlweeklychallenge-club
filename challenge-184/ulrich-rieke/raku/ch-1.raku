use v6 ;

say "Enter strings in the form of aa9999, that is 2 letters and 4 digits!" ;
say "Enter <return> to end!" ;
my @strings ;
my $line = $*IN.get ;
while ( $line ) {
  while ( $line !~~ /<[a..z]>**2<[0..9]>**4/ ) {
      say "string should start with 2 letters and then 4 digits! Re-enter!" ;
      $line = $*IN.get ;
  }
  @strings.push( $line ) ;
  $line = $*IN.get ;
}
my @output ;
for (0..@strings.elems - 1 ) -> $i {
  say $i ;
  if ( $i < 10 ) {
      @output.push( "0$i" ~ @strings[ $i ].substr( 2 ) ) ;
  }
  else {
      @output.push( ~$i ~ @strings[ $i ].substr( 2 ) ) ;
  }
}
say @output.join( ',' ) ;
