use v6 ;

sub count( @array , $element ) {
   return @array.grep( {$_ == $element} ).elems ;
}

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @uniques = @numbers.unique ;
my %frequencies ;
for @uniques -> $num {
   %frequencies{ $num } = count( @numbers , $num ) ;
}
my @sorted = @uniques.sort( { %frequencies{$^a} <=> %frequencies{$^b} || 
      $^b <=> $^a } ) ;
my @result ;
for @sorted -> $num {
   for (1..%frequencies{ $num } ) {
      @result.push( $num ) ;
   }
}
say "(" ~ @result.join( ',' ) ~ ")" ;
