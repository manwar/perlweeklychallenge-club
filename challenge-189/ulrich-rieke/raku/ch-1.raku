use v6 ;

say "Enter a number of characters, separated by a blank!" ;
my $line = $*IN.get ;
my @characters = $line.split( /\s/ ) ;
say "Enter a target character!" ;
my $target = $*IN.get ;
my @sorted = @characters.sort( {$^a leg $^b} ) ;
my $current = 0 ;
while ( not ( @sorted[ $current ] leg $target) == More ) {
  $current++ ;
}
say @sorted[ $current ] ;
