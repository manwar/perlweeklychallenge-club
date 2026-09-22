use v5.38;

# Trivial solution: (rev s) . (s)
# But we also want the shortest possible palindrome

sub palindromize($s, $index) {
    my $pre = substr $s, 0, $index;
    my $center = substr $s, $index, 1;
    my $post = substr $s, $index+1;

    # flip pre and make it look like post
    my $diff = length($post) - length($pre);
    if ($diff > 0) {
	$pre = reverse $pre;
	my $addition = substr $post, length($pre);
	$pre .= $addition;
	$pre = reverse $pre;
    } else {
	$post = reverse $post;
	my $addition = substr $pre, length($post);
	$post .= $addition;
	$post = reverse $post;
    }
    return $pre.$center.$post;
}

sub is_close($s) {
    my $x = reverse $s;
    my $x1 = " ".$x;
    my $x2 = $x;
    my @X1 = split '', $x1;
    my @X2 = split '', $x2;
    shift @X2;			# remove first element
    my @S = split '', $s;
    my $close = 0;
    for my $i (0 .. $#X1) {
	next if ($X1[$i] eq " ");
	last if (!exists $S[$i]);
	if ($X1[$i] ne $S[$i]) {
	    $close = 1;
	}
    }
    return 1 if ($close == 0);
    $close = 0;
    for my $i (0 .. $#X2) {
	next if ($X2[$i] eq " ");
	last if (!exists $S[$i]);
	if ($X2[$i] ne $S[$i]) {
	    $close = 1;
	}
    }
    return -1 if ($close == 0);
    return 0;
}

sub proc($s) {
    say "Input: $s";
    my $output = "";
    my $x = reverse $s;
    if ($x eq $s) {
	$output = $s;
    } else {
	# If $s is close to a palindrome, we determine the axis index. If it is not close, axis index is 0.
	my $shift = is_close($s);
	if ($shift != 0) {
	    # Find axis point, pass this as the index value.
	    # shift = 1 is flip and shift right one unit
	    # shift = -1 is flip and shift left one unit
	    my $axis = length($s)/2 + $shift;
	    $output = palindromize($s, $axis);
	} else {
	    # Trivial reflection, account for multiple starting letters
	    my @S = split '', $s;
	    my $cnt = 0;
	    for my $i (0 .. $#S) {
		if ($S[$i] eq $S[$i+1]) {
		    $cnt++;
		} else {
		    last;
		}
	    }
	    $output = palindromize($s, $cnt);
	}
    }
    say "Output: $output";
}
my $s;
$s = "aacecaaa";
proc($s);
$s = "abcd";
proc($s);
$s = "racecar";
proc($s);
$s = "bananas";
proc($s);
$s = "aaaaa";
proc($s);
