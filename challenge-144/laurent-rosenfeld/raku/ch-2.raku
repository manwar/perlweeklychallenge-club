uses v6;

sub ulam ($first, $second) {
    my @sequence = $first, $second;
    for 1..10 {
        my @sums = sort grep { $_ > @sequence[*-1] },
            map { [+] $_[0, 1] }, @sequence.combinations: 2;
        my $last = 0;
        for 0..@sums.end -> \i {
            next if @sums[i] == $last;
            push @sequence, @sums[i] and last if i >= @sums.end;
            $last = @sums[i] and next if @sums[i] == @sums[i+1];
            push @sequence, @sums[i] and last;
        }
    }
    return @sequence;
}
for (1,2), (2,3), (2,5) -> $test {
  say "$test => ", ulam |$test;

}
