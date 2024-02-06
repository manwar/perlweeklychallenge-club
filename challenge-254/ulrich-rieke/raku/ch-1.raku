use v6 ;

say "Enter a number!" ;
my $line = $*IN.get ;
my $number = $line.Int ;
my $third = FatRat.new( 1 , 3 ) ;
my $cuberoot = $number ** $third ;
say ( $cuberoot == floor( $cuberoot ) ) ;
