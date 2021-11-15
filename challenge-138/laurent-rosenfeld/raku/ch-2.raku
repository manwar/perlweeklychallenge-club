use v6;

sub partition (Int $sum is copy, @in) {
    if @in.elems == 0 {
        $*found = 1 if $sum == $*root;
        return;
    }
    for 1..@in.elems -> $i {
        my $new-sum = $sum + join "", @in[0..($i-1)];
        last if $new-sum > $*root;
        partition $new-sum, @in[$i..@in.end];
    }
}

sub split-square (UInt $sq) {
    my $*root = sqrt($sq).Int;
    say "$sq is not a perfect square\n" and return 0 if $*root² != $sq;
    my $*found = 0;
    partition(0, $sq.comb);
    return $*found;
}
for <1 27 81 100 225 1296 6561 9801> -> $test {
    say $test.fmt("%5d\t") , split-square $test;
}
