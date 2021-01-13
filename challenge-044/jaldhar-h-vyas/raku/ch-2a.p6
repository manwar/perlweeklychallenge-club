#!/usr/bin/perl6

multi sub MAIN {
    my @result;
    my $n = 200;

    while ($n != 1) {
        if ($n %% 2) {
            @result.unshift('double');
            $n /= 2;
        } else {
            @result.unshift('add one');
            $n--;
        }
    }

    @result.join(q{, }).say;
}