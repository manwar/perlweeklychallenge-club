use v6 ;

say "Enter some computer languages, separated by blanks!" ;
my $line = $*IN.get ;
my @languages = $line.words ;
say "Enter some popularity indices for these languages!" ;
$line = $*IN.get ;
my @popularity = $line.words.map( {.Int} ) ;
my @pairs ;
for (0..@languages.elems - 1) -> $index {
   @pairs.push( (@popularity[ $index ] , @languages[ $index ] ) ) ;
}
my @sorted = @pairs.sort( { $^a[0] cmp $^b[0] } ) ;
print "(" ;
say @sorted.map( {$_[1]} ).join( ',' ) ~ ")" ;
