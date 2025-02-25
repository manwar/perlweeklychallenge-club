use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @encoded = $line.words.map( {.Int} ) ;
say "Enter an integer!" ;
$line = $*IN.get ;
my $number = $line.Int ;
#if we are given a xor b = c and we are given only a and c , we can find 
#b by a xor c since xor is its own inverse function!
my @decoded ;
@decoded.push( $number ) ;
for @encoded -> $num {
   my $lastNum = @decoded[*-1] ;
   @decoded.push( $num +^ $lastNum ) ;
}
say '(' ~ @decoded.join( ',' ) ~ ')' ;
