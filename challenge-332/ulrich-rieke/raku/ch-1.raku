use v6 ;

say "Enter a date as year-month-day!" ;
my $date = $*IN.get ;
my @dateparts = $date.split( / '-' / ) ;
my @transformed = @dateparts.map( { (+$_).base( 2 ) } ) ;
say @transformed.join( '-' ) ;
