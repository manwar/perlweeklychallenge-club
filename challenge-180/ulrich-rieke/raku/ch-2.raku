use v6 ;

say "Enter a line of integers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/ ).map( {.Int} ) ;
say "Enter an integer!" ;
$line = $*IN.get ;
my $number = +$line ;
say @numbers.grep( { $_ > $number} ) ;
