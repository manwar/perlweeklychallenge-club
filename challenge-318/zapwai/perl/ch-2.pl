use v5.38;

# Return 1 if a sub-array (of length len) can be reversed once in s to make r
sub subswap($len, $s, $r) {
    my @s = @$s;
    my @t = @$r;
    for my $i (0 .. $#s - $len + 1) {
	my @sub = @s[$i .. $i + $len - 1];
	my @new = @s;
	splice @new, $i, $len, reverse @sub;
	my $cnt = 0;
	for (0 .. $#t) {
	    $cnt++ if ($new[$_] == $t[$_]);
	}
	if ($cnt == scalar @t) {
	    return 1;
	}
    }
    return 0;
}

sub proc($s, $r) {
    say "Input: \@source = @$s, \@target = @$r";
    my $ver = "false";
    if (scalar @$s == 1) {
	$ver = "true" if ($$s[0] = $$r[0]);
    } else {
	for my $len (2 .. scalar @$s) {
	    if (subswap($len, $s, $r) == 1) {
		$ver = "true";
		last;
	    }
	}
    }
    say "Output: $ver";
}

my @source = (3, 2, 1, 4);
my @target = (1, 2, 3, 4);
proc(\@source, \@target);
@source = (1, 3, 4);
@target = (2, 3, 5);
proc(\@source, \@target);
@source = (2);
@target = (2);
proc(\@source, \@target);

