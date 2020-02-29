# Test: perl6 ch-1.p6 55

sub MAIN(Int $number) {
    my $i = 1;

    my $new_number = $number;
    while (!($new_number ~~ /^^<[01]>+$$/)) {
        $new_number = $number * $i++;
    }

    say "Smallest multiple of $number is $new_number";

}
