use 5.036;

my @ints = @ARGV;

@ints = sort { $a <=> $b } @ints;

my $min_difference;
my @pair_starts;

for (my $i = 1; $i < @ints; ++$i) {
    my $difference = $ints[$i] - $ints[$i-1];
    if (! defined $min_difference || $difference < $min_difference) {
        $min_difference = $difference;
        @pair_starts = ($ints[$i-1]);
    }
    elsif ($difference == $min_difference) {
        push @pair_starts, $ints[$i-1];
    }
}

for my $int (@pair_starts) {
    say sprintf '[%d, %d]', $int, $int + $min_difference;
}
