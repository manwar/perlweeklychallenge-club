use v6 ;

#this task calculates the first 10 Bell numbers applying the triangle
#rule that carries his name

my @bellnumbers = ( 1 ) ;
my @current_row  ;#where we collect the numbers in the row
my @previous_row = ( 1 ) ;
while (@bellnumbers.elems < 10) {
  @current_row.push( @previous_row[ *-1 ] ) ;
  my $current_index = 0 ;
  repeat {
      $current_index++ ;
      @current_row[ $current_index] = @current_row[ $current_index - 1 ]
    + @previous_row[ $current_index - 1 ] ;
      } until ( @current_row.elems == @previous_row.elems + 1 ) ;
    @bellnumbers.push( @current_row[ 0 ] ) ;
    @previous_row = @current_row ;
    @current_row = ( ) ;
}
say "These are the first 10 Bell numbers!" ;
for ( 1 .. 10 ) -> $i {
  if ( $i < 10 ) {
      print " $i : " ;
  }
  else {
      print "$i : " ;
  }
  say "@bellnumbers[ $i - 1 ]" ;
}
