use v6 ;

sub createLine( $start ) {
   my @line ;
   for (0..7) -> $pos {
      if ( $pos %% 2 ) {
	 @line.push( $start ) ;
      }
      else {
	 if ( $start eq "light" ) {
	    @line.push( "dark" ) ;
	 }
	 else {
	    @line.push( "light" ) ;
	 }
      }
   }
   return @line ;
}

say "Enter the coordinates of a chess field!" ;
my $field = $*IN.get ;
my $cols = "abcdefgh" ;
my $col = $field.substr( 0 , 1 ) ;
my $row = $field.substr( 1 , 1 ).map( {.Int} ) ;
my @baseline = createLine( "dark" ) ;
my $result ;
if ( $row == 1 ) {
   $result = @baseline[ $cols.index( $col ) ] eq "light" ;
}
else {
   my @col_line = createLine( @baseline[ $cols.index( $col )] ) ;
   $result = @col_line[ $row - 1 ] eq "light" ;
}
say $result ;
