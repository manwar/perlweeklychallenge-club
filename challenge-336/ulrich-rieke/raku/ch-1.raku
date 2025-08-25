use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int } ) ;
my %frequencies ;
for @numbers -> $k {
   %frequencies{$k}++ ;
}
my $result ;
if %frequencies.keys.elems == 1 {
   my $num = %frequencies.keys[0] ;
   $result = $num > 1 ;
}
else {
   my @pairs ;
   for %frequencies.keys -> $k {
      @pairs.push( [$k , %frequencies{$k}] ) ;
   }
   my @sorted = @pairs.sort( {$^a[1] <=> $^b[1] } ) ;
   my $mini = @sorted[0][1] ;
   $result = $mini > 1 && @sorted[1..@sorted.elems - 1].grep( {$_[1] %% $mini} )
      .elems == @sorted.elems - 1 ;
}
say $result ;

