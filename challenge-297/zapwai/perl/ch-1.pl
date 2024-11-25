use v5.38;

sub subseq_is_balanced($len, @bin) {
    for my $i (0 .. @bin - $len) {
	my ($zeros, $ones) = (0, 0);
	my @n = @bin[$i .. $i+$len-1];
	for (@n) {
	    if ($_ == 0) {
		$zeros++;
	    } else {
		$ones++;
	    }
	}
	if ($zeros == $ones) {
	    return 1;
	}
    }
    return 0;
}

sub proc(@bin) {
    say "Input: \@binary = @bin";
    my $len = 2;
    my $maxlen = 0;
    do {
	$maxlen = $len if (subseq_is_balanced($len, @bin));
	$len++;
    } while ($len <= @bin);
    say "Output: $maxlen";
}

my @bin = (1, 0);
proc(@bin);
@bin = (0, 1, 0);
proc(@bin);
@bin = (0,0,0,0,0);
proc(@bin);
@bin = (0,1,0,0,1,0);
proc(@bin);
