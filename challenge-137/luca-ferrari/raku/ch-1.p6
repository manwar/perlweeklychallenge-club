#!raku

sub MAIN() {
    for 1900 .. 2100 -> $year {
        $year.say if Date.new( '%04d-12-31'.sprintf( $year ) ).week-number == 53;
    }
}
