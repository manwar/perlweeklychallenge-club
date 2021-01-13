#!/usr/bin/perl6


multi sub MAIN(
    Int $N #= > 1
    where { $N > 1 }
) {

    my @arr = (1 .. 50).pick($N);
    my @peak;

    for 0 ..^ @arr.elems -> $i {
        if @arr[$i] > (@arr[$i - 1] // 0) && @arr[$i] > (@arr[$i + 1] // 0) {
            @peak.push(@arr[$i]);
        }
    }
    say 'array: ', @arr.join(q{, });
    say 'Peak: ', @peak.join(q{, });
}