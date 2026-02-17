use v6 ;

say "Enter some 0 and 1 , <enter> to end!" ;
my @matrix ;
my $line = $*IN.get ;
while ( $line ) {
   my @row = $line.words.map( {.Int} ) ;
   @matrix.push( @row ) ;
   $line = $*IN.get ;
} 
my $result ;
my $lines = 0 ;
for @matrix -> @row {
   if (@row.elems == @row.grep( {$_ == 0} ).elems ) {
      $lines++ ;
   }
}
if ( $lines != 1 ) {
   $result = -1 ;
}
else {
   my $pos = 0 ;
   while ( not ( so 0 == @matrix[$pos].all ) ) {
      $pos++ ;
   }
   for (0..@matrix.elems - 1) -> $row {
      if ( $row != $pos && @matrix[$row][$pos] != 1 ) {
         $result = -1 ;
         last ;
      }
      $result = $pos ;
   }
}
$result.say ;
