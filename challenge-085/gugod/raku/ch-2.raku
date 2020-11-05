
sub is-power-of-two-ints(Int $N) {
    my $ab = (2..$N.sqrt).map({ $^n => $N.log($^n).floor }).first({ $N == .key ** .value });
    return False unless defined $ab;
    return True, $ab.key, $ab.value;
}

for @*ARGS.map({ .Int }) -> $n {
    my ($yes, $a, $b) = is-power-of-two-ints($n);
    if $yes {
        say "1 as $n = $a ** $b";
    } else {
        say 0;
    }
}
