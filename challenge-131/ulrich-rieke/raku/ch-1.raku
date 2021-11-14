use v6 ;

say "Enter a line of integers , separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/ ).unique.sort( { $^a <=> $^b } ) ;
my $len = @numbers.elems ;
my $chunksize = (1 .. $len).pick ;
my @consecutives ;
my $currentPos = 0 ;
while ( $currentPos + $chunksize - 1 < $len - 1 ) {
  @consecutives.push( @numbers[$currentPos..$currentPos + $chunksize - 1] ) ;
  $currentPos += $chunksize ;
}
if ( $currentPos < $len ) {
  @consecutives.push( @numbers[$currentPos..$len - 1] ) ;
}
@consecutives.say ;
