use v6 ;

say "Enter a string consisting of grouped digits only!" ;
my $numberstring = $*IN.get ;
my %frequencies ; # for digit frequencies ;
$numberstring.comb.map( { %frequencies{$_}++ } ) ;
my $maxi = 0 ; # greatest number so far
for %frequencies.keys -> $k {
   if ( $k ne '0' ) {
      my $current = ($k x %frequencies{$k}).Int ;
      if ( $current > $maxi ) {
         $maxi = $current ;
      }
   }
}
$maxi.say ;
