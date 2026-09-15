use v6 ;

say "Enter some sorted integer numbers separated by blanks!" ;
my $firstline = $*IN.get ;
my @firstnumbers = $firstline.words.map( {.Int} ) ;
say "Enter some more sorted integers!" ;
my $secondline = $*IN.get ;
my @secondnumbers = $secondline.words.map( {.Int} ) ;
for @secondnumbers -> $num {
   @firstnumbers.push( $num ) ;
}
@firstnumbers .= sort( {$^a <=> $^b} ) ;
my $len = @firstnumbers.elems ;
if ( $len %% 2 ) {
   say (@firstnumbers[($len div 2 ) - 1] + @firstnumbers[$len div 2])/ 2 ;
}
else {
   say @firstnumbers[$len div 2] ;
}
