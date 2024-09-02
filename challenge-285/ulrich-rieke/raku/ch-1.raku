use v6 ;

say "Enter some routes, start and destination separated by blanks!" ;
say "Separate routes by ','!" ;
my $line = $*IN.get ;
my @routes = $line.split( /','/ ) ;
my %pairs ;
for @routes -> $route {
   my ($start , $destination) = $route.split( /\s/ ) ;
   %pairs{$start} = $destination ;
}
say join( ',' , %pairs.values.grep( {not %pairs{$_}:exists } )) ;
