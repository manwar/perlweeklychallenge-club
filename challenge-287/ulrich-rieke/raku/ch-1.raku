use v6 ;

say "Enter a password!" ;
my $word = $*IN.get ;
my $totalsteps = 0 ;
my $len = $word.chars ;
if ( $len < 6 ) {
   $totalsteps += 6 - $len ;
}
if ( $word !~~ /<[a..z]>/ ) {
   if ( $len >= 6 ) {
      $totalsteps++ ;
   }
}
if ( $word !~~ /<[A..Z]>/ ) {
   if ( $len >= 6 ) {
      $totalsteps++ ;
   }
}
if ( $word !~~ /\d/ ) {
   if ( $len >= 6 ) {
      $totalsteps++ ;
   }
}
if ( $word ~~ /(.) $0 $0/ ) {
   $totalsteps++ ;
}
$totalsteps.say ;
