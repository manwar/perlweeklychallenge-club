use v5.38;

sub has($x, @l) {
    for (@l) {
	return 1 if ($x == $_);
    }
    0
}

sub dig3(@l) {
    return 0 if ($l[0] == 0);
    my $s = join("", @l);
    return $s if (length $s == 3 && 0 == $s % 2);
}

sub p(@n) {
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

sub perm(@ints) {
    my @list;
    my @n = (0 .. scalar @ints - 1);
    for (p(@n)) {
	my @nums = map {$ints[$_]} @$_;
	do {
	    my $x = dig3(@nums);
	    push @list, $x unless (has($x, @list));
	    pop @nums;
	} while (@nums);
    }
    return @list;
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    print "Output: ";
    my @l = perm(@ints);
    shift @l;
    say join(", ", sort @l);
}

my @ints=(2,1,3,0);
proc(@ints);

@ints = (2,2,8,8,2);
proc(@ints);

