use v6 ;

say "Enter some integers, separated by ',' !" ;
my $line = $*IN.get ;
my @numbers = $line.split( ',').map( {.Int} ) ;
my $prod = [*] @numbers ;
my $result ;
if ( $prod > 0 ) {
   $result = 1 ;
}
elsif ( $prod == 0 ) {
   $result = 0 ;
}
else {
   $result = -1 ;
}
say $result ;
