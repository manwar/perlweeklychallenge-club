use v6;

my @fib = 1, 2, * + * ... * > 1000; # 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597

sub fib-seq (UInt $n) {
    my $count = 0;
    ++$count and .say for grep { $_.sum == $n }, @fib.grep({$_ <= $n }).combinations;
    return $count;
}
for 16, 9, 15, 89, 100 {
    say "Number of sequences for $_: ", fib-seq($_), "\n";
}
