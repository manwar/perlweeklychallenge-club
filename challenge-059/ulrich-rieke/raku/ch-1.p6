use v6 ;

sub reorder( @array , Int $k ) {
  my @first_part = @array.grep( { $_ < $k } ) ;
  my @second_part = @array.grep( { $_ >= $k } ) ;
  my @reordered = @first_part.append: @second_part ;
  return @reordered ;
}

#the last element in the argument list is k, the rest in front is the
#array
sub MAIN( *@ARGS ) {
  my @numarray = @ARGS[0..@ARGS.elems - 2] ;
  my $num = @ARGS[ *-1 ] ;
  my @reordered = reorder( @numarray, $num ) ;
  my $len = @numarray.elems ;
  @reordered[0..$len - 2].map( { print "$_ -> " }) ;
  say @reordered[*-1] ;
}
