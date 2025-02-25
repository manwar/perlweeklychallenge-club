use v5.38;
sub comb($n) {
    my @n = (0 .. $n-1);
    my @c;
    for my $i (0 .. 2**$n - 1) {
	my $form = "%0$n".'b';
	my $x = sprintf($form, $i);
	my @comb;
	my @d = split "", $x;
	for my $j (0 .. $#d) {
	    push @comb, $n[$j] if $d[$j] == 1;
	}
	push @c, \@comb;
    }
    return @c;
}

# Return true if there are at most x 0s and y 1s in set c
sub is_weight($x, $y, @c) {
    my ($n0, $n1) = (0, 0);
    for (@c) {
	if ($_ == 0) {
	    $n0++;
	} else {
	    $n1++;
	}
    }
    return ($n0 <= $x && $n1 <= $y);
}

sub proc($x, $y, @str) {
    say "Input: str = @str, x = $x, y = $y";
    my $min = 1000;
    my @c = comb(scalar @str);
    for my $r (@c) {
	my @l;
	for (@$r) {
	    push @l, $str[$_];
	}
	if (is_weight($x, $y, @l)) {
	    $min = @l;
	}
    }
    say "Output: $min";
}

my @str = ("10", "0001", "111001", "1", "0");
my $x = 5;
my $y = 3;
proc($x, $y, @str);

@str = ("10", "1", "0");
$x = 1;
$y = 1;
proc($x, $y, @str);
