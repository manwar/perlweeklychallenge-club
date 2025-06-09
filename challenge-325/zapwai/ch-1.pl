use v5.38;
sub proc(@binary) {
    say "Input: @binary";
    my $max = 0;
    my $run = 0;
    my $flag = 0;
    for my $i (0 .. $#binary) {
	if ($binary[$i] == 1) {
	    if ($flag == 0) {
		$run = 1;
		$flag = 1;
	    } else {
		$run++;
	    }
	} else {
	    $flag = 0;
	}
	$max = $run if ($max < $run);
    }
    say "Output: $max";
}

my @binary = (0, 1, 1, 0, 1, 1, 1);
proc(@binary);
@binary = (0,0,0,0);
proc(@binary);
@binary = (1,0,1,0,1,1);
proc(@binary);
