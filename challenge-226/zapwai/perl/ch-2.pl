use v5.30;
my @ints = (1,5,0,3,5);
say "Input: \@ints = (" . join(",",@ints) . ")";
my $cnt = 0;
unless (is_zero(@ints)) {
    do {
	$cnt++;
	slim(\@ints);
    } until (is_zero(@ints));
}
say "Output: $cnt";

sub is_zero {
    for (0 .. $#_) {
	return 0 if ($_[$_] != 0);
    }
    return 1;
}

sub slim {
    my $r = shift;
    my $min = 100;
    foreach (@$r) {
	next if ($_ == 0);
	$min = $_ if ($_ < $min);
    }
    for my $i (0 .. $#$r) {
	$$r[$i] = $$r[$i] - $min unless ($$r[$i] == 0);
    }
}
