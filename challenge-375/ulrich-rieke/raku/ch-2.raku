use v6 ;

say "Enter a number and a k value separated by blanks!" ;
my $line = $*IN.get ;
my @parts = $line.words ;
my $numberstring = @parts[0] ;
my $k = +@parts[1] ;
my $result ;
my $len = $numberstring.chars ;
if ( $k == $len ) {
   $result = 1 ;
}
elsif ( $k > $len ) {
   $result = 0 ;
}
else {
   my @numbers ;
   for ( 0..$len - $k) -> $pos {
      @numbers.push( $numberstring.substr( $pos , $k ).Int ) ;
   }
   $result = @numbers.grep( { $numberstring.Int %% $_} ).elems ;
}
say $result ;
