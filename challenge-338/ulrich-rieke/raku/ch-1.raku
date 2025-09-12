use v6 ;

say "Enter some integers separated by whitespace, <return> to end!" ;
my $line = $*IN.get ;
my @matrix ;
while ( $line !~~ /^$/ ) {
   my @numbers = $line.words.map( {.Int} ) ;
   @matrix.push( @numbers ) ;
   $line = $*IN.get ;
}
my @sums ;
for @matrix -> $row {
   @sums.push( $row.sum ) ;
}
say @sums.max ;
