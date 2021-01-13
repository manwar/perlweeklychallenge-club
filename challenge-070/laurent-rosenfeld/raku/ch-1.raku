use v6;
subset Non0 of Int where * > 0;

# For fun, indexing strings with subscripts
multi sub postcircumfix:<[ ]> (Str $s, Int $n) {
    substr-rw $s, $n, 1;
}
# Not used here, but more fun
multi sub postcircumfix:<[ ]> (Str $s, Range $r) {
    substr-rw $s, $r;
}

sub MAIN ($s is copy, Non0 $c = 3, Non0 $o = 4) {
    my $n = $s.chars;
    die "Invalid values" if $c + $o > $n;
    for 1..$c -> $i {
        my $tmp = $s[$i % $n];
        substr-rw($s, $i % $n, 1) = $s[($i + $o) % $n];
        substr-rw($s, ($i + $o) % $n, 1) = $tmp;
    }
    say $s
}
