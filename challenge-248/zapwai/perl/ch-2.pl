use v5.30;
my $a = [
    [1,  2,  3,  4],
    [5,  6,  7,  8],
    [9, 10, 11, 12]
];
my $n = @$a - 1;
my $m = @{$$a[0]} - 1;
say "Input: \$a = [";
for (0 .. $n) {
    say "\t[" . join(",", @{$$a[$_]}) ."]";
}
say "\t]";
my @b;
for my $i (0 .. $n - 1) {
    for my $j (0 .. $m - 1) {
	$$b[$i][$j] = subsum($i,$j);
    }
}
say "Output: \$b = [";
for (0 .. $n - 1) {
    say "\t[" . join(",", @{$$b[$_]}) ."]";	
}
say "\t]";
sub subsum {
    my ($i, $j) = @_;
    return $$a[$i][$j] + $$a[$i+1][$j] + $$a[$i][$j+1] + $$a[$i+1][$j+1];
}
