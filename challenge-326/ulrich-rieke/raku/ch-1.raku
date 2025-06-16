use v6 ;

say "Enter a valid date in the form YYYY-MM-DD !" ;
my $line = $*IN.get ;
my $someDate ;
$line ~~ s:g/\- 0/\-/ ;
if ( $line ~~ /^(\d ** 4) '-' (\d+) '-' (\d+)$/ ) {
   my ( $year , $month , $day ) = ( +$0 , +$1 , +$2 ) ;
   say ( $year , $month , $day ) ;
   $someDate = Date.new( $year , $month , $day ) ;
   my $start = Date.new( $year , 1 , 1 ) ;
   say ($someDate - $start) + 1 ;
}
else {
   say "Invalid format!" ;
}
