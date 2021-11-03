use v6 ;

my @longYears ;
for (1900 .. 2100) -> $year {
  my $date = Date.new( "$year-12-31") ;
  if ( $date.week-number == 53 ) {
      @longYears.push( $year ) ;
  }
}
my $start = 0 ;
my $len = @longYears.elems ;
while ( $start + 5 <= $len ) {
  say @longYears[$start..$start + 4].join( ", ") ~ "," ;
  $start += 5 ;
}
say @longYears[$start .. $len - 1].join( ", " ) ;
