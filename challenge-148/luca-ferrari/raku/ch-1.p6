#!raku





sub MAIN() {

    my @eban-units = 2, 4, 6;
    my @eban-teens = 12;
    my @eban-tens  = 3, 4, 5, 6;

    $_.say if @eban-units.grep( $_ ) for 1 .. 10;
    $_.say if @eban-teens.grep( $_ ) for 11 .. 19;
    $_.say if @eban-tens.grep( ( $_ / 10 ).Int ) && @eban-units.grep( $_ % 10 ) for 20 .. 100;

}
