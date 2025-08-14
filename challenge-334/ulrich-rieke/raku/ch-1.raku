use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter two valid indices into this array!" ;
$line = $*IN.get ;
my @indices = $line.words.map( {.Int} ) ;
say [+] @numbers[@indices[0]..@indices[1]]
