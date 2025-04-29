use v5.38;

sub proc($r, $s) {
    say "Input: @$r, @$s";
    my $min = -1;
    for my $item (@$r) {
	for my $item2 (@$s) {
	    if ($item eq $item2) {
		$min = $item;
		last;
	    }
	    last if ($min != -1);
	}
    }
    say "Output: $min";
}

my @array_1 = (1, 2, 3, 4);
my @array_2 = (3, 4, 5, 6);
proc(\@array_1, \@array_2);
@array_1 = (1, 2, 3);
@array_2 = (2, 4);
proc(\@array_1, \@array_2);
@array_1 = (1, 2, 3, 4);
@array_2 = (5, 6, 7, 8);
proc(\@array_1, \@array_2);
