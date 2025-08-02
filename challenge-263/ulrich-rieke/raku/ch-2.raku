use v6 ;


say "Enter an even number of integers, separated by blanks!" ;
my $line = $*IN.get ;
my @firstNumbers = $line.words.map( {.Int} ) ;
say "Enter an even number of integers, again!" ;
$line = $*IN.get ;
my @secondNumbers = $line.words.map( {.Int} ) ;
my %keyHash ;
#regard consecutive numbers of both number arrays as key-value pairs
#and enter them to a hash
my $len = @firstNumbers.elems ;
my $pos = 0 ;
while ( $pos < $len - 1 ) {
   if ( %keyHash{ @firstNumbers[ $pos ] }:exists ) {
      %keyHash{ @firstNumbers[ $pos ] } += @firstNumbers[ $pos + 1 ] ;
   }
   else {
      %keyHash{ @firstNumbers[ $pos ] } = @firstNumbers[ $pos + 1 ] ;
   }
   $pos += 2 ;
}
#same for @secondNumbers ;
$pos = 0 ;
$len = @secondNumbers.elems ;
while ( $pos < $len - 1 ) {
   if ( %keyHash{ @secondNumbers[ $pos ] }:exists ) {
      %keyHash{ @secondNumbers[ $pos ] } += @secondNumbers[ $pos + 1 ] ;
   }
   else {
      %keyHash{ @secondNumbers[ $pos ] } = @secondNumbers[ $pos + 1 ] ;
   }
   $pos += 2 ;
}
my @sorted = %keyHash.keys.sort( {$^a <=> $^b} ) ;
print "[ " ;
for @sorted -> $s {
   print "[$s," ~ %keyHash{ $s } ~ "] " ;
}
say "]" ;
