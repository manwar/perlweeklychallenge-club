sub MAIN ( Str $str is copy = 'abcdefgh', Int $C = 1, Int $O = 7) {


    ## easier to see the results if we spread things out a bit
    say "Count   $C";
    say "Offset  $O";
    say "Start   ",  $str.comb.join: ' ';

    swap( $str, $C, $O );

    say "Result  ", $str.comb.join: ' ';

}


## ## ## ## ## SUBS:

sub swap ($str is rw, $C, $O) {
    my $n = $str.chars;
    for 1..$C -> $i {
        my $tmp = $str.substr(($i+$O) % $n, 1);
        $str.substr-rw(($i+$O) % $n, 1) = $str.substr-rw( $i % $n, 1 );
        $str.substr-rw( $i % $n, 1 ) = $tmp;
    }
    return $str;
}
