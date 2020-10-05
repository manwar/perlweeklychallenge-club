unit sub MAIN( $file where $file.IO.f );

my @ignore = <. ! ? " ( ) , 's -->;

my $words = $file
    .IO
    .slurp
    .subst( /@ignore/, ' ', :g )
    .words
    .Bag
    .classify( *.value );

say join " ", $_, slip sort $words{$_}>>.key
    for sort $words.keys;