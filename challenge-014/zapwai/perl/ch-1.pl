use v5.38;
my @seq = (0);
my $n = 0;
do {
    vaneck(\@seq);
    $n++;
} while ($n < 19);
say @seq;

sub vaneck($r) {
    if ($#$r == 0) {
	push @$r, 0;
    } else {
	my $pop = $$r[$#$r];
	my $done_flag = 0;
	my $j = $#$r - 1;
	do {
	    if (($done_flag == 0) && ($$r[$j] == $pop)) {
		$done_flag = 1;
		push @$r, $#$r - $j;
	    }
	    $j--;
	} while ($j >= 0);
	unless ($done_flag) {
	    push @$r, 0;
	}
    }
}

