use v6 ;

say "Enter a string and a positive integer!" ;
my $line = $*IN.get ;
my ($word , $numberstring) = $line.words ;
my $number = $numberstring.Int ;
$word ~~ s:g/'-'// ;
my $wordlen = $word.chars ;
my $firstlen = $wordlen % $number ;
my $solution ;
my $pos = 0 ;
if ( $firstlen != 0 ) {
   my $firstpart = $word.substr( 0 , $firstlen ) ;
   $solution = $firstpart ~ "-" ;
   $pos = $firstlen ; 
}
while ( $pos + $number < $wordlen ) {
   $solution ~= $word.substr( $pos , $number ) ;
   $solution ~= "-" ;
   $pos += $number ;
}
$solution ~= $word.substr( $pos ) ;
say $solution ;
