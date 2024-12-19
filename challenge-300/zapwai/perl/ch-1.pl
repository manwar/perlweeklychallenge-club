use v5.38;

sub is_beauty(@n) {
    my $cnt = 0;
    for my $i (1 .. $#n + 1) {
	$cnt++ if ($n[$i - 1] % $i == 0 || $i % $n[$i - 1] == 0);
    }
    return ($cnt == @n);
}

sub p(@n) {
    # An array of refs to the permutations
    my @p;
    return (\@n) if (@n == 1);

    if (@n == 2) {
	push @p, \@n;
	my @l = reverse @n;
	push @p, \@l;
	return @p;
    }

    my @starts = @n;
    for my $i (0 .. $#n) {
	my $start = shift @starts;
	my @l = @n;
	splice(@l, $i, 1);
	for (p(@l)) {
	    my @out;
	    push @out, $start;
	    push @out, @$_;
	    push @p, \@out;
	}
    }
    return @p;
}

sub perm($n) {
    my @n = (1 .. $n);
    return p(@n);
}

sub proc($n) {
    say "Input: \$n = $n";
    my $cnt = 0;
    for (perm($n)) {
	$cnt++ if is_beauty(@$_);
    }
    say "Output: $cnt\n";
}

proc(2);
proc(1);
proc(10);

