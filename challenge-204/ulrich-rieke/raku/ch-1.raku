use v6 ;

say "Enter some integers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @differences ;
for (0..$len - 2 ) -> $i {
  @differences.push( @numbers[ $i + 1 ] - @numbers[ $i ] ) ;
}
if @differences.grep( { $_ <= 0 } ).elems == $len - 1 ||
@differences.grep( { $_ >= 0 } ).elems == $len - 1 {
  say 1 ;
}
else {
  say 0 ;
}
