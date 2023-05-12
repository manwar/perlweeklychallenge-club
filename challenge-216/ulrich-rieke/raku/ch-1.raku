use v6 ;

say "Enter some words , separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say "Enter the 2 parts of a registration number!" ;
$line = $*IN.get ;
my @registrationline = $line.words ;
my $registration = @registrationline[0] ~ @registrationline[1] ;
my $comp = set($registration.lc.comb.grep( { $_ ~~ / <alpha> / } ))  ;
my @selected = @words.grep( { $comp (<=) set( $_.comb) } ) ;
say "(" ~ @selected.join( ',' ) ~ ")" ;
