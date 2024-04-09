use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter some indices into the number array!" ;
$line = $*IN.get ;
my @indices = $line.words.map( {.Int} ) ;
my @pairs = @numbers Z @indices ;
my @target ;
for @pairs -> $p {
   if ( @target.elems == 0) {
      @target.push( @numbers[ 0 ] ) ;
   }
   else {
      @target.splice( $p[1] , 0 , $p[0] ) ;
   }
}
print "(" ;
@target.join( ',' ).print ;
say ")" ;
