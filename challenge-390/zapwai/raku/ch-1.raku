use v6;

sub parse($s) {
    my $left_ind = -1;
    my @char = $s.comb;
    for 0 .. @char.end -> $i {
	$left_ind = $i if @char[$i] eq '[';
    }
    return $s if $left_ind == -1;
    my $o = $s;
    # loop until no more brackets exist
    while $left_ind != -1 {
	# Find last location of a starting bracket, store the substring to tmp and repeat it num times
	$left_ind = -1;
	
	for 0 .. @char.end -> $i {
	    $left_ind = $i if @char[$i] eq '[';
	}
	unless $left_ind == -1 {
	    my $right_ind = index $o, ']', $left_ind;
	    my $tmp = substr $o, $left_ind + 1, $right_ind - $left_ind - 1;
	    my $num = "";
	    my $j = $left_ind - 1;
	    while ($j >= 0) {
		if @char[$j] ~~ /\d/ {
		    $num = @char[$j] ~ $num;
		    $j--;
		} else {
		    last;
		}
	    }
	    $j++;
	    # $j now contains the left index of a substring we want to remove, we stop at $right_ind, replacing with $fill
	    my $fill = $tmp x $num;
	    my @f = $fill.comb;
	    splice @char, $j, $right_ind - $j + 1, @f;
	    $o = @char.join('');
	}
    }
    return $o;
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
