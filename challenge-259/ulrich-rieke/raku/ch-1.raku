use v6 ;

say "Enter a date in the format year-month-day!" ;
my $date = $*IN.get ;
while ( $date !~~ /\d **4 \- \d ** 2  \- \d ** 2/ ) {
   say "Enter in the correct format!" ;
   $date = $*IN.get ;
}
say "Enter a day offset!" ;
my $offset = $*IN.get ;
say "Enter any bank holidays in the above format, <return> to end!" ;
my @holidays ;
my $free = $*IN.get ;
while ( $free ) {
   @holidays.push( $free ) ;
   $free = $*IN.get ;
}
(my $year , my $month , my $day ) = $date.split( /\-/ ) ;
my $currentDate = Date.new( $year.Int , $month.Int , $day.Int ) ;
while ( $offset != 0 ) {
   $currentDate = $currentDate + 1;
   if ( $currentDate.day-of-week < 6 && ( so ~$currentDate eq @holidays.none ) ) {
      $offset-- ;
   }
}
say $currentDate ;
