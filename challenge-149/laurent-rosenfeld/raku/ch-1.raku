sub MAIN (Int $max = 20) {       # 20: default input value
    my $fibo = set(0, 1, * + * ...^  * > 1000);
    my $count = 0;
    my @numbers = gather {
        for 0 .. Inf -> $num {
            if $num.comb.sum (elem) $fibo {
                take $num;
                $count++;
                last if $count >= $max;
            }
        }
    }
    say @numbers;
}
