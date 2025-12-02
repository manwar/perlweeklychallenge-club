use v6 ;

say "Enter a string!" ;
my $word = $*IN.get ;
my $len = $word.chars ;
my $count = 0 ;
for (0..$len - 3) -> $i {
    if ( $word.substr( $i , 3 ).comb.unique.elems == 3 ) {
        $count++ ;
    }
}
say $count ;
