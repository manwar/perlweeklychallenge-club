sub is-brazilian (Int $n) {
    return True if $n %% 2 and $n >= 8;
    return False if $n <= 3;
    for 2..^($n-1) -> $base {
        return True if $n.base($base) ~~ /^(\d)$0+$/;
    }
    False;
}

say "Brazilian numbers less than or equal to 36 are:";
for 1..36 -> $m {
    print "$m " if is-brazilian $m;
}
say "";
