use v6 ;

say "Enter an even number of numbers , separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {+$_} ) ;
my %averages ;
my @sorted = @numbers.sort( {$^a <=> $^b} ) ;
my $len = @numbers.elems ;
for (0..$len div 2 - 1 ) -> $pos {
   my $average = (@sorted[$pos] + @sorted[$len - $pos - 1] ) / 2.0 ;
   %averages{$average}++ ;
}
say %averages.keys.elems ;
