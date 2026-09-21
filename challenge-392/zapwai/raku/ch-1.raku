use v6;

# Trivial solution: (rev s) . (s)
# But we also want the shortest possible palindrome

sub palindromize($s, $index) {
    my $pre = substr $s, 0, $index;
    my $center = substr $s, $index, 1;
    my $post = substr $s, $index+1;

    # flip pre and make it look like post
    my $diff = $post.chars - $pre.chars;
    if $diff > 0 {
	$pre = $pre.flip;
	my $addition = substr $post, $pre.chars;
	$pre ~= $addition;
	$pre = $pre.flip;
    } else {
	$post = $post.flip;
	my $addition = substr $pre, $post.chars;
	$post ~= $addition;
	$post = $post.flip;
    }
    return $pre~$center~$post;
}

sub is_close($s) {
    my $x = $s.flip;
    my $x1 = " "~$x;
    my $x2 = $x;
    my @X1 = $x1.comb;
    my @X2 = $x2.comb;
    @X2.shift;			# remove first element
    my @S = $s.comb;
    my $close = 0;
    for 0 .. @X1.end -> $i {
	next if @X1[$i] eq " ";
	last if !defined @S[$i];
	if @X1[$i] ne @S[$i] {
	    $close = 1;
	}
    }
    return 1 if $close == 0;
    $close = 0;
    for 0 .. @X2.end -> $i {
	next if @X2[$i] eq " ";
	last if !defined @S[$i];
	if @X2[$i] ne @S[$i] {
	    $close = 1;
	}
    }
    return -1 if $close == 0;
    return 0;
}

sub proc($s) {
    say "Input: $s";
    my $output = "";
    my $x = $s.flip;
    if $x eq $s {
	$output = $s;
    } else {
	# If $s is close to a palindrome, we determine the axis index. If it is not close, axis index is 0.
	my $shift = is_close($s);
	if $shift != 0 {
	    # Find axis point, pass this as the index value.
	    # shift = 1 is flip and shift right one unit
	    # shift = -1 is flip and shift left one unit
	    my $axis = $s.chars/2 + $shift;
	    $output = palindromize($s, $axis);
	} else {
	    # Trivial reflection, account for multiple starting letters
	    my @S = split '', $s;
	    my $cnt = 0;
	    for 0 .. @S.end -> $i {
		if @S[$i] eq @S[$i+1] {
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
