#!/usr/bin/perl6

sub MAIN(Int $n) {
    my $num = $n;
    my $sign = 0;

    if ($num < 0) {
        $sign = 1;
        $num = abs($num);
    }

    if $num > 2_147_483_647 {
        say '0';
    } else {
        my $reversed = 0; 

        while $num > 0 {
            $reversed = $reversed * 10 + $num % 10; 
            $num div= 10; 
        }

        say $sign ?? q{-} !! q{}, $reversed;
    }
}