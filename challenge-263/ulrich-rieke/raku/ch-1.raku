use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter a target integer!" ;
$line = $*IN.get ;
my $k = +$line ;
my @sorted = @numbers.sort( { $^a <=> $^b} ) ;
my @indices = (0..@numbers.elems -1).grep( { @sorted[ $_] == $k } ) ;
print "(" ;
print @indices.join(',') ;
say ")" ;
