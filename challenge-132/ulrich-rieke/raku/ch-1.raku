use v6 ;

say "Enter birth date in the form <year/month/day>" ;
my $birthdate = $*IN.get ;
while ( $birthdate !~~ /^^(\d ** 4) '/' (\d ** 2) '/' (\d ** 2)$$/ ) {
  say "Enter birth date in the sequence <year/month/day>" ;
  $birthdate = $*IN.get ;
}
my $referenceDate = Date.new( +$0 , +$1 , +$2 ) ;
my Date $today = Date.today ;
my $days_alive = $today - $referenceDate ;
my Date $mirrorBefore = $referenceDate.earlier( days => $days_alive ) ;
my Date $mirrorAfter = $today.later( days => $days_alive ) ;
say "$mirrorBefore, $mirrorAfter" ;
