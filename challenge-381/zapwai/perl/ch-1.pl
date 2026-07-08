use v5.38;

sub check_row(@m) {
    my $cnt = 0;
    for my $r (@m) {
	my @row = @$r;
      J: for my $j (1 .. @m) {
	    for my $val (@row) {
		if ($val == $j) {
		    $cnt++;
		    next J;
		}
	    }
	}
    }
    return ($cnt == @m*@m);
}

sub check_col(@m) {
    my $cnt = 0;
    my @n;			# tranpose of m
    for my $i (0 .. $#m) {
	my @row = @{$m[$i]};
	for my $j (0 .. $#row) {
	    $n[$j][$i] = $row[$j];
	}
    }
    return check_row(@n);
}

sub proc(@m) {
    say "Input: \@matrix = ";
    say "\t@$_" for (@m);
    say "Output: ", (check_row(@m) && check_col(@m)) ? "true" : "false";
}

my @m = ([1, 2, 3, 4],
	 [2, 3, 4, 1],
	 [3, 4, 1, 2],
	 [4, 1, 2, 3],);
proc(@m);

@m = ([1]);
proc(@m);

@m = ([1, 2, 5],
      [5, 1, 2],
      [2, 5, 1],);
proc(@m);

@m = ([1, 2, 3],
      [1, 2, 3],
      [1, 2, 3],);
proc(@m);
@m = ([1, 2, 3],
      [3, 1, 2],
      [3, 2, 1],);
proc(@m);
