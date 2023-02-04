use v5.30.0;
my @array1 = (1, 5, 5, 2, 8);
my @array2 = (2,6,8,5);
my @array3 = (9,8,13,13,2,2,15,17);
my @array4 = (2,1,2,1,3);
my @array5 = (1,3,3,2,1,2,3,3,2);
my @test = (\@array1,\@array2,\@array3,\@array4,\@array5);
for my $ref (@test) {
    my @array = @$ref;
    my @valley;		      # push an array ref to each valley here.
    my $begin_index = 0;
    my $incr_flag = 0;		# flag after descent is complete.
    for (0 .. $#array - 1) {
	if ($incr_flag) {
	    if ( $array[$_ + 1] < $array[$_] ) {
		push @valley, [ @array[$begin_index .. $_] ];
		$begin_index = $_;
		for my $i (1 .. $_) { # check if it was level
		    if ( $array[$_] == $array[$_ - $i] ) {
			$begin_index--;
		    } else {
			last;
		    }
		}
		$incr_flag = 0;
	    }
	} else {
	    if ( $array[$_ + 1] > $array[$_] ) {
		$incr_flag = 1;
	    }
	}
    }
    push @valley, [ @array[$begin_index .. $#array] ];
    my $max = 0;
    my $ind;
    for (0 .. $#valley) {
	if (scalar @{$valley[$_]} > $max) {
	    $max = scalar @{$valley[$_]};
	    $ind = $_;
	}
    }
    say "Input: @array";
    say "Output: @{$valley[$ind]}";
    say "-" x 10;
}
