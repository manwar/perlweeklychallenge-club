my @primes = grep { .is-prime }, 1..100;
my %seen;

sub partition (Int $m, Int $n) {
    return if $n < 2;
    if $n == 2 {
        for @primes -> $i {
            last if $i >= $m;
            my $j = $m - $i;
            next if $j == $i;
            next if %seen{$i} or %seen{$j};
            return $i, $j if $j.is-prime;
        }
        return;
    } else {
        for @primes -> $i {
            last if $i >= $m;
            %seen = $i => True;
            my @sub-partition = partition($m - $i, $n-1);
            next if @sub-partition.elems < 2;
            return ($i, @sub-partition).flat;
        }
        return;
    }
}
for <18 2>, <19 3>, <17 3>, <25 2> -> $test {
    my @partition = partition($test[0], $test[1]);
    say @partition.elems < 2 ?? "$test: No solution" !! "Solution for $test: @partition[]";
}
