use v6 ;

say "Enter some integers , separated by blanks!" ;
my $line = $*IN.get ;
my @firstNumbers = $line.words.map( {.Int} ) ;
say "Enter the same number of integers, separated by blanks!" ;
$line = $*IN.get ;
my @secondNumbers = $line.words.map( {.Int} ) ;
@firstNumbers .= sort( {$^a <=> $^b } ) ;
@secondNumbers .= sort( {$^a <=> $^b} ) ;
my @zipped = @firstNumbers Z @secondNumbers ;
my $comp = @zipped[0][1] - @zipped[0][0] ;
if ( @zipped.grep( {$_[1] - $_[0] == $comp } ).elems == @firstNumbers.elems ) {
   say $comp ;
}
else {
   say " " ;
}
