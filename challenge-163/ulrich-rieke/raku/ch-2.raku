use v6 ;

sub createRow( @array ) {
  my @output ;
  my $len = @array.elems ;
  for (1 .. $len - 1 ) -> $current {
      @output.push( @array[1 .. $current].sum ) ;
  }
  return @output ;
}

say "Enter a row of numbers, separated by a blank!" ;
my $row = $*IN.get ;
while ( $row !~~ /^\s*\d+ % ' '$/ ) {
  say "You should only enter numbers separated by a blank!" ;
  $row = $*IN.get ;
}
my @numbers = $row.split( /\s/ ).map( {.Int} ) ;
my @outputRow = @numbers ;
repeat {
  @outputRow = createRow( @outputRow ) ;
} until ( @outputRow.elems == 1 ) ;
say @outputRow[0] ;
