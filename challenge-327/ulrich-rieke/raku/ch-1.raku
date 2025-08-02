use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my %found ;
@numbers.map( {%found{$_}++} ) ;
my @selected = (1..$len).grep( {not %found{$_}:exists} ) ;
say '(' ~ @selected.join( ',' ) ~ ')' ;
