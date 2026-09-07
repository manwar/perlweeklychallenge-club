use v5.38;

sub parse($s) {
    my $left_ind = -1;
    my @char = split '', $s;
    for my $i (0 .. $#char) {
	$left_ind = $i if ($char[$i] eq '[');
    }
    return $s if ($left_ind == -1);

    # loop until no more brackets exist
    while ($left_ind != -1) {
	# Find last location of a starting bracket, store the substring to tmp and repeat it num times
	$left_ind = -1;
	
	for my $i (0 .. $#char) {
	    $left_ind = $i if ($char[$i] eq '[');
	}
	unless ($left_ind == -1) {
	    my $right_ind = index $s, ']', $left_ind;
	    my $tmp = substr $s, $left_ind + 1, $right_ind - $left_ind - 1;
	    my $num = "";
	    my $j = $left_ind - 1;
	    while ($char[$j] =~ /\d/) {
		$num = $char[$j] . $num;
		$j--;
	    }
	    $j++;
	    # $j now contains the left index of a substring we want to remove, we stop at $right_ind, replacing with $fill
	    my $fill = $tmp x $num;
	    my @f = split '', $fill;
	    splice @char, $j, $right_ind - $j + 1, @f;
	    $s = join '', @char;
	}
    }
    return $s;
}

sub proc($s){
    say "Input: \$str = $s";
    my $out = parse($s);
    say "Output: $out";
}

my $str = "2[3[a]]";
proc($str);
$str = "10[a]";
proc($str);
$str = "a2[b]c3[d]e";
proc($str);
$str = "2[a2[b]c]";
proc($str);
$str = "1[a]2[b3[c]]";
proc($str);
