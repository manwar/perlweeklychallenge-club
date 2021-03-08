#!/usr/bin/raku

sub MAIN(
    Int $N #= length of hash-counting string
) {
    my $wasHash = 0;
    my @hash-counting;
    my $pos = $N;

    while $pos > 0 {
        if $wasHash {
            @hash-counting.unshift("$wasHash");
            $pos -= "$wasHash".chars;
            $wasHash = 0;
        } else {
            @hash-counting.unshift('#');
            $wasHash = $pos;
            $pos--;
        }
    }

    @hash-counting.join(q{}).say;
}