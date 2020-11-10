use v6 ;

#for the sake of this task I do not do a particular amount of data entry
#checking

sub enterArray( ) {
  my @numbers ;
  say "enter a minimum of 3 positive real numbers ( -1 to end )!" ;
  my $num = $*IN.get ;
  while ( $num != -1 ) {
      @numbers.push( $num ) ;
      $num = $*IN.get ;
  }
  return @numbers ;
}

my @array = enterArray( ) ;
my @combis = @array.combinations( 3 ) ;
my @sums = @combis.map( {[+] $_ } ) ;
if ( @sums.grep( { 1 < $_ < 2 }).elems > 0 ) {
  say 1 ;
}
else {
  say 0 ;
}
