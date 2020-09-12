use v6;
# Original task!

my @fib = (1, 2, -> $a, $b { $a + $b } ...^ * > 1000).reverse;
for 1..1000 -> $n {
    my $curr = $n;
    my @result;
    for @fib -> $i {
        next if $i > $curr;
        push @result, $i;
        last if $i == $curr;
        $curr -= $i;
    }
    say "$n -> ", @result;
}
