use v6 ;

sub format( $var , Str $unit --> Str ) {
  if ( $var == 0 ) {
      return "" ;
  }
  if ( $var == 1 ) {
      return "1 $unit" ;
  }
  if ( $var > 1 ) {
      return ( "$var $unit" ~ "s" ) ;
  }
}

say "Enter a first date as yyyy-mm-dd!" ;
my $line = $*IN.get ;
while ( $line !~~ /^(\d ** 4)'-'(\d ** 2)'-'(\d ** 2 )$/ ) {
  say "Please enter date as yyyy-mm-dd!" ;
  $line = $*IN.get ;
}
my $date1 = Date.new( +$0 , +$1 , +$2 ) ;
say "Enter a second date as yyyy-mm-dd!" ;
$line = $*IN.get ;
while ( $line !~~ /^(\d ** 4)'-'(\d ** 2)'-'(\d ** 2 )$/ ) {
  say "Please enter date as yyyy-mm-dd!" ;
  $line = $*IN.get ;
}
my $date2 = Date.new( +$0 , +$1 , +$2 ) ;
#for every full leap year  we have to count
#1 year as 366 days! So we have to subtract the number of leap years
#between the 2 days from the number of days between the dates
my $toBeSubtracted = 0 ; #days we have to subtract for full leap years
if ( $date2.year( ) - $date1.year( ) >= 1 ) {
  if ( $date1.is-leap-year( ) ) {
      if ( $date1.month() == 1 && $date1.day( ) == 1 ) {
    $toBeSubtracted++ ;
      }
  }
  if ( $date2.is-leap-year( ) ) {
      if ( $date2.month( ) == 12 && $date2.day( ) == 31 ) {
    $toBeSubtracted++ ;
      }
  }
  if ( $date2.year( ) - $date1.year( ) > 1 ) {
      my @yearsCovered = ($date1.year( ) + 1 .. $date2.year( ) - 1 ) ;
      for @yearsCovered -> $y {
    my $dt = Date.new( "$y-01-01" ) ;
    if ( $dt.is-leap-year( ) ) {
        $toBeSubtracted++ ;
    }
      }
  }
}
my $diffDays = $date2 - $date1 ;
$diffDays -= $toBeSubtracted ;
my $years = $diffDays div 365 ;
my $days = $diffDays - $years * 365 ;
print( format( $years , "year" ) ) ;
say( " " ~ format( $days , "day") ) ;
