use v6 ;


say "Enter  holiday start date for Foo in the form day-month!" ;
my $line = $*IN.get ;
while ( $line !~~ /^(\d **2 ) '-' (\d ** 2)$/ ) {
  say "Enter again in the form above!" ;
  $line = $*IN.get ;
}
my $firstStart = Date.new( 2022 , +$1 , +$0 ) ;
say "Enter the end date for Foo in the form day-month" ;
$line = $*IN.get ;
while ( $line !~~ /^(\d **2 ) '-' (\d ** 2)$/ ) {
  say "Enter again in the form above!" ;
  $line = $*IN.get ;
}
my $firstEnd = Date.new( 2022 , +$1 , +$0 ) ;
say "Enter holiday start date for Bar in the form day-month!" ;
$line = $*IN.get ;
while ( $line !~~ /^(\d **2 ) '-' (\d ** 2)$/ ) {
  say "Enter again in the form above!" ;
  $line = $*IN.get ;
}
my $secondStart = Date.new( 2022 , +$1 , +$0 ) ;
say "Enter holiday end date for Bar in the form day-month!" ;
$line = $*IN.get ;
while ( $line !~~ /^(\d **2 ) '-' (\d ** 2)$/ ) {
  say "Enter again in the form above!" ;
  $line = $*IN.get ;
}
my $secondEnd = Date.new( 2022 , +$1 , +$0 ) ;
my @firstSpan ;
@firstSpan.push( $firstStart ) ;
my $nextDate = $firstStart.succ( ) ;
while ( $nextDate ne $firstEnd ) {
  @firstSpan.push( $nextDate ) ;
  $nextDate = $nextDate.succ( ) ;
}
@firstSpan.push( $firstEnd ) ;
my @secondSpan ;
@secondSpan.push( $secondStart ) ;
$nextDate = $secondStart.succ( ) ;
while ( $nextDate ne $secondEnd ) {
  @secondSpan.push( $nextDate ) ;
  $nextDate = $nextDate.succ( ) ;
}
@secondSpan.push( $secondEnd ) ;
my $firstSet = @firstSpan.Set ;
my $secondSet = @secondSpan.Set ;
my $commonDates = $firstSet (&) $secondSet ;
say $commonDates.elems ~ " days" ;
