use v6 ;

my %temperatures ;
for 'temperature.txt'.IO.lines -> $line {
  my ( $date , $temperature ) = $line.split( /','/ ) ;
  %temperatures{ $date } = ( $temperature ~~ s/(\s*)(\d+)$/$1/ ) ;
}
my @dates ;
for %temperatures.keys -> $str {
  my ( $year , $month, $day ) = $str.split( /'-'/ ) ;
  my $date = Date.new( $year , $month , $day ) ;
  @dates.push( $date ) ;
}
@dates = @dates.sort( { $^a <=> $^b } ) ;
my $len = @dates.elems ;
for ( 1 .. $len - 1 ) -> $i {
  if ( %temperatures{ @dates[$i].Str } >
    %temperatures{ @dates[ $i - 1 ].Str } ) {
      say @dates[$i].Str ;
  }
}
