#!raku



sub switch( Str $string where { $string ~~ / ^ <[0 1]>+ $ / } ) {
    my @bits;
    for $string.split( '', :skip-empty ) {
        @bits.push( 0 ) && next if $_ == 1;
        @bits.push: 1 if $_ == 0;
    }

    @bits.join;
}


sub reverse( Str $string where { $string ~~ / ^ <[0 1]>+ $ / } ) {
    $string.split( '', :skip-empty ).reverse.join;
}

sub MAIN( Int:D $max? = 100  ) {
    my $current-string;
    for 0 .. $max {
        $current-string = ''  if $_ == 0;
        $current-string = '0' if $_ == 1;
        next if $_ <= 1;
        $current-string = $current-string ~ '0' ~ switch( reverse( $current-string ) );
    }

    $current-string.csay;

}
