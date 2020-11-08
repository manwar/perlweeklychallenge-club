use v6;

my $n = @*ARGS[0] // 15;
sub find-factors ($n is copy) {
    my %factors;
    my $max = ($n/2).Int;
    for 2..$max -> $i {
        while  $n %% $i {
            %factors{$i}++;
            $n /= $i;
        }
    }
    say %factors;
    return 1 if 1 < [gcd] %factors.values;
    return 0;
}
say find-factors $n;
