use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @selected = @numbers.grep( {$_ %% 2 && $_ %% 3} ) ;
if (@selected) {
   my $avg = ([+] @selected) / @selected.elems ;
   say $avg.round ;
}
else {
   say 0 ;
}
