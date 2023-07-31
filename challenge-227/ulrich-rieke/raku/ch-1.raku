use v6 ;

say "Enter a year, best between 1853 and 9999!" ;
my $year = $*IN.get ;
my $sum = 0 ;
for (1..12) -> $month {
   my $d = Date.new( $year , $month , 13 ) ;
   if ( $d.day-of-week == 5 ) {
      $sum++ ;
   }
}
say "There are $sum Friday 13th in $year!" ;
