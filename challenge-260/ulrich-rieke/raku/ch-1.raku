use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my %uniques ;
my %frequencies ;
for @numbers -> $num {
   %uniques{ $num }++ ;
}
for %uniques.keys -> $num {
   %frequencies{ @numbers.grep( {$_ == $num} ).elems }++ ;
}
if ( %uniques.keys.elems == %frequencies.keys.elems) {
   say 1 ;
}
else {
   say 0 ;
}
