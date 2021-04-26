#!/usr/bin/raku

sub chowla(Int $n) {
    return [+] (1 ^.. $n div 2).grep({ $n %% $_; });
}

sub MAIN() {
    my @numbers;

    for 1 .. 20 -> $n {
        @numbers.push(chowla($n));
    }

    @numbers.join(q{, }).say;
}