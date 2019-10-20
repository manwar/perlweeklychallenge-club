use v6 ;

my @dates ;
for (2019..2100) -> $year {
  my $d = Date.new( $year , 12 , 25 ) ;
  if ( $d.day-of-week == 7 ) {
      @dates.push( $d ) ;
  }
}
@dates.map( { say ~$_ } ) ;
