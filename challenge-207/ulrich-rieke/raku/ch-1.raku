use v6 ;

my $row1 = "qwertyuiop" ;
my $row2 = "asdfghjkl" ;
my $row3 = "zxcvbnm" ;
say "Enter some words separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @output ;
for @words -> $word {
  my @letters = $word.lc.comb ;
  my $len = @letters.elems ;
  if ( @letters.grep( { $row1.contains( $_ )} ).elems == $len ||
    @letters.grep( {$row2.contains( $_ )} ).elems == $len ||
    @letters.grep( {$row3.contains( $_)}).elems == $len ) {
      @output.push( $word ) ;
  }
}
if ( @output ) {
  say @output.join( ',' ) ;
}
else {
  say "()" ;
}
