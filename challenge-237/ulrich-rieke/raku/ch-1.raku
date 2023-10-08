use v6 ;

say "Please enter a year( positive integer ) , a month( integer from 1 to 12)," ;
say " the index of a given weekday( integer from 1 to 5 ) , and a weekday( 1 to 7 )" ;
my $line = $*IN.get ;
my @dateparts = $line.words.map( {.Int} ) ;
#construct a date for the first day in the given month of the given year
my $d = Date.new( @dateparts[ 0 ] , @dateparts[ 1 ] , 1 ) ;
#add a day until you reach the given weekday
while ( $d.day-of-week != @dateparts[ 3 ] ) {
   $d .= later( days => 1 ) ;
}
#if we want the day of the first given weekday we're already there
if ( @dateparts[ 2 ] == 1 ) {
   say $d.day ;
}
#otherwise, we add as many days as necessary to reach the n'th given weekday
else {
   $d .= later( days => ( @dateparts[ 2 ] - 1 ) * 7 ) ;
   if ( $d.month != @dateparts[ 1 ] ) {#a month rollover occurred! we must output 0!
      say 0 ;
   }
   else {
      say $d.day ; #otherwise, we output the day
   }
}
