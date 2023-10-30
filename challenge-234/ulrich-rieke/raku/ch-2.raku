use v6 ;

sub count( @array , $element ) {
   return @array.grep( {$_ == $element} ).elems ;
}

say "Enter some positive integers, separated by spaces!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @uniques = @numbers.unique ;
my $combis = @uniques.combinations( 3 ) ;
my %frequencies ;
for @uniques -> $n {
   %frequencies{ $n } = count( @numbers , $n ) ;
}
my $sum = 0 ;
my $len = $combis.elems ;
for ( 0..$len - 1 ) -> $n {
   my $combi = $combis[ $n ] ;
   my $product = 1 ;
   for (0..2) -> $d {
      $product *= %frequencies{ $combi[ $d ] } ;
   }
   $sum += $product ;
}
say $sum ;

