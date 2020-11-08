use v6;

my $n = @*ARGS[0].Int // 15;
say find-power $n;

sub find-power (Int $n) {
    return 1 if $n == 1; # trivial solution: 1 ** 2
    OUTERLOOP: for 2..$n.sqrt.Int -> $base {
        my $exp = 2;
        loop {
            my $power = $base ** $exp;
            return 1 if $power == $n;
            next OUTERLOOP if $power > $n;
            $exp++;
        }
    }
    return 0;
}
