use v6 ;

say "Enter a string with non-digit English characters and digits without leading 0!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @numbers ;
for @words -> $w {
   if ( $w ~~ /^<[1..9]><[0..9]>*$/ ) {
      @numbers.push( $w.Int ) ;
   }
}
say @numbers ;
my @differences ;
for (1..@numbers.elems - 1) -> $pos {
   @differences.push( @numbers[$pos] - @numbers[$pos - 1] ) ;
}
say (@differences.elems == @differences.grep( {$_ > 0} ).elems);
