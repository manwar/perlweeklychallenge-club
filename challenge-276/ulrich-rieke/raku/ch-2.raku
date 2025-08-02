use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my %frequencies ;
@numbers.map( {%frequencies{$_}++} ) ;
my $maximum = %frequencies.values.max ;
my @keys = %frequencies.keys ;
my $number = @keys.grep( {%frequencies{$_} == $maximum} ).elems ;#number of element
#with maximum frequency
#what we look for is the product of maximum frequency and the number of elements that
#have that maximum frequency!
say ( $number * $maximum ) ;
