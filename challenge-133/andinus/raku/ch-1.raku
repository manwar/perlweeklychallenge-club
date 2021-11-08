#| Integer Square Root
sub MAIN(UInt $n) {
    my $x = $n +> 1;
    loop {
        given ($x + ($n / $x)) / 2 {
            last if $x == $_;
            $x = $_;
        }
    }
    put $x;
}
