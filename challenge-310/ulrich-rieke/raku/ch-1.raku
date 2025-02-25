use v6 ;

say "Enter some lines with integers, integers being separated by blanks!" ;
say "Enter <return> to end!" ;
my @numberarray ;
my $line = $*IN.get ;
while ( $line ) {
   my @numbers = $line.words.map( {.Int} ) ;
   @numberarray.push( @numbers.Set ) ;
   $line = $*IN.get ;
}
my $intersect = [(&)] @numberarray ;
print "( " ;
for $intersect.keys -> $k {
   print "$k " ;
}
say ")" ;
