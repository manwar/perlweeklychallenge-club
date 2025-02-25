use v5.38;

sub bin_to_dec(@bin) {
    @bin = reverse @bin;
    my $sum = 0;
    for my $i (0 .. $#bin) {
	$sum += $bin[$i]*2**$i
    }
    return $sum;
}

sub proc(@bin) {
    say "Input: \@bin = @bin";
    my @t;
    for my $i (0 .. $#bin) {
	push @t, (bin_to_dec(@bin[0..$i])%2 == 0) ? "true" : "false";
    }
    print "Output: "; say "@t";
}

my @bin = (1,0,1);
proc(@bin);

@bin = (1,1,0);
proc(@bin);
