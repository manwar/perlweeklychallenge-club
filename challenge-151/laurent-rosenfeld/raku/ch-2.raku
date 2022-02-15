use v6;

sub get_best(@in, $sum-so-far is copy) {
    if @in.elems <= 2  {
        $sum-so-far += @in.max;
        $*best-so-far = $sum-so-far if $sum-so-far > $*best-so-far;
        return;
    }
    for 0, 1 -> $i {
        get_best @in[$i + 2 .. @in.end], $sum-so-far + @in[$i];
    }
}
my @valuables = (2, 4, 5), (4, 2, 3, 6, 5, 3), (4, 2, 5, 10);
for @valuables -> $test {
    my $*best-so-far = 0;  # dynamic scope variable
    get_best $test, 0;
    say $test, " -> ", $*best-so-far;
}
