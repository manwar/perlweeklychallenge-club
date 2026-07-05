use v5.36;

my $str = $ARGV[0] // die "Usage: $0 STRING\n";
$str = lc $str;

my $sum = 0;
for my $i (0 .. length($str) - 1) {
    my $c = substr $str, $i, 1;

    $sum += ($i + 1) * (1 + ord('z') - ord($c));
}

say $sum;
