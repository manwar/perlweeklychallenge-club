use v6 ;

sub myFlip( $number is copy ) {
   if ( $number == 0 ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter some 0 or 1, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words ;
my $len = @numbers.elems ;
my $counter = 0 ;
my @matrix ;
while ( $counter != $len - 1 ) {
   @matrix.push( $line ) ;
   say "Enter $len elements of 0 or 1 , separated by blanks!" ;
   $line = $*IN.get ;
   $counter++ ;
}
@matrix.push( $line ) ;
my @result ;
for @matrix -> $l {
   my $changed = $l.words.reverse.map( {myFlip( $_.Int)} ).join( ',' ) ;
   @result.push( $changed ) ;
}
print "(" ;
for @result -> $r {
   print "(" ~ $r ~ ")" ~ " ";
}
say ")" ;
