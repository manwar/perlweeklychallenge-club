use v6 ;

my $currentDate = Date.new( 1999 , 12 , 31 ) ;
my $reordered ;
my @palindromedates ;
repeat {
  $currentDate += 1 ;
  my $datestr = $currentDate.Str ;
  $datestr ~~ /(\d ** 4) '-' (\d+ ) '-' (\d+)/ ;
  $reordered = ~$2 ~ ~$1 ~ ~$0 ;
  if ( $reordered eq $reordered.flip ) {
      @palindromedates.push( $reordered ) ;
  }
} until ( $currentDate.year == 2999 && $currentDate.month == 12 &&
      $currentDate.day == 31 ) ;
.say for @palindromedates ;
