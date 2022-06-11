use v6 ;

say "Enter a set of integers, separated by a blank space!" ;
my $line = $*IN.get ;
my @numbers = $line.split(/\s+/).map( {.Int} ) ;
my $len = @numbers.elems ;
my $am = ([+] @numbers) / $len ;
my $gm = ([*] @numbers) ** ( 1 / $len ) ;
my $hm = $len / ( [+] @numbers.map( { 1 / $_ } )) ;
my @means = ($am, $gm , $hm).map( {sprintf( "%.1f" , $_)} ) ;
my @output = ("AM = " , "GM = " , "HM = ") Z~ @means ;
say @output.join( ", " ) ;
