use v5.38;
sub proc($str) {
    say "Input: \$str = $str";
    my (@open, @valid);
    my @p = split '', $str;
    for my $i (0 .. $#p) {
	my $char = $p[$i];
	next if (@open == 0 && $char eq ')');
	if (@open == 0) {
	    push @open, $i;
	} else {
	    if ($char eq ')') {
		push @valid, pop(@open);
	    } else {
		push @open, $i;
	    }
	}
    }
    @valid = sort {$a <=> $b} @valid;
    my $diff = 0;
    my $maxdiff = 0;
    for my $i (0 .. $#valid - 1) {
	$diff = $valid[$i+1] - $valid[$i];
	if ($diff > $maxdiff) {
	    $maxdiff = $diff;
	}
    }
    my $o = "";
    if ($maxdiff < 3) {
	$o = 2 * scalar @valid;
    } else {
	# Each nest increases valid skip-length by one. (Default is 2)
	my $skip_len = 2;

	my @val;	 # a multi-array for the non-contiguous case
	my @curr;	 # the current contiguous block, ref pushed to val
	for my $i (0 .. $#valid - 1) {
	    push @curr, $valid[0] if ($i == 0);
	    $diff = $valid[$i+1] - $valid[$i];
	    
	    if ($diff > $skip_len) { # non-contiguous case
		my @a = @curr;
		push @val, \@a;
		@curr = ();
		$skip_len = 2;
	    } else {
		$skip_len -= $diff - 2;
	    }
	    push @curr, $valid[$i+1];
	}
	push @val, \@curr;

	my $max_len = 0;
	for my $r (@val) {
	    my $len = scalar @$r;
	    $max_len = $len if ($len > $max_len);
	}
	
	$o = 2*$max_len;
    }
    say "Output: $o";
    
}

my $str = '(()())';
proc($str);
$str = ')()())';
proc($str);
$str = '((()))()(((()';
proc($str);
$str = '))))((()(';
proc($str);
$str = '()(()';
proc($str);

# keep an @open array that holds the index of any opening bracket, the left-hand (
# when a right-hand ) is encountered, you pop the index off of @open and onto @valid.
# [right-hand ) are ignored if @open is empty]

# You can then double the length of the largest contiguous block in @valid.
# (adjacent indices means nested structure, one-space-away means neighboring pairs)

#  first example valid: {0, 1, 3} -> 6
# second example valid: {1,3} -> 4
# third valid : {0,1,2,6, 11} -> 8
# four valid: {6} -> 2
# five valid: {0,3}  -> 2


# # Some Extra Cases

# my $str = '(())()'; # {0, 1, 4} -> 6
# proc($str);
# $str = '(())()()'; # {0, 1, 4, 6} -> 8
# proc($str);
# $str = '(()(()))()'; # {0, 1, 3, 4, 8} -> 10
# proc($str);
# $str = '(()(())())'; # {0, 1, 3, 4, 7} -> 10
# proc($str);

# # Skip_len decreases when there is an abnormal skip (not a diff of 2, i.e. a closed pair)

# $str = '(()(())()())';
# proc($str);
# # {0, 1, 3, 4, 7, 9} -> 12 (skip_len decreases at the 4 to 7 gap.)
# $str = '(()(())())()';
# proc($str);
# # {0, 1, 3, 4, 7, 10} -> 12 (skip_len decreases twice)
# $str =  '(()(())()))()';
# proc($str);
# # {0, 1, 3, 4, 7, 11} -> 10 (gap is larger than skip_len, non-contiguous case)

