my $n = 1000000;
my ( $x, $y, $area, $n2 ) = ( $n, 0, 0, $n * $n );
while ( $x > 0 ) {
    $y++ while $x * $x + $y * $y < $n2;
    $area += $y;
    $x--;
}
printf( "Pi whith 8 decimal places: %.8f\n", $area * 4 / $n2 );