use v6 ;

say "Enter a string consisting of lowercase letters only!" ;
my $line = $*IN.get ;
my $len = $line.chars ;
my %frequencies ;
for (0..$len - 2 ) -> $pos {
   %frequencies{ $line.substr( $pos , 2 ) }++ ;
}
my @sorted = %frequencies.keys.sort( { %frequencies{ $^b } cmp 
      %frequencies{ $^a } || $^a cmp $^b } ) ;
say @sorted[ 0 ] ;
