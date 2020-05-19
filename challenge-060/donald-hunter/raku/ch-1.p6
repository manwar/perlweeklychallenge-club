#| Convert column value to name where 1 <= value <= 16384
multi MAIN(Int $value is copy where 1 <= * <= 16384) {
    my @alphabet = 'A'..'Z';
    my @chars = gather {
        repeat {
            take @alphabet[$value mod 26 - 1];
            $value div= 26;
        } while $value > 0;
    }
    say @chars.reverse.join;
}

#| Convert column name to value
multi MAIN(Str $name where /^<[A..Z]>+$/) {
    my %map = flat 'A'..'Z' Z 1..26;
    say $name.comb.map(-> $c { %map{$c} }).reduce({ $^a * 26 + $^b });
}
