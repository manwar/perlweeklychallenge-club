use v5.38;
sub proc($str) {
    say "Input: \$str = $str";
    my @pos;
    my $group_pos;
    my $current_letter;
    my $group_flag = 0;
    my $group_letter;
    my $len = 0;
    for my $i (0 .. length($str) - 2) {
	$current_letter = substr $str, $i, 1;
	my $next_letter = substr $str, $i + 1, 1;
	if ($group_flag) {
	    if ($current_letter eq $next_letter) {
		$len++;
	    } else {
		$group_flag = 0;
		if ($len > 2) {
		    push @pos, $group_pos;
		}
	    }
	} else {
	    if ($current_letter eq $next_letter) {
		$len = 2;
		$group_letter = $current_letter;
		$group_flag = 1;
		$group_pos = $i;
	    }
	}
    }
    if ($group_flag) {
	if ($len > 2) {
	    push @pos, $group_pos;
	}
    }
    say "Output: @pos";
}

my $str = "abccccd";
proc($str);

$str = "aaabcddddeefff";
proc($str);

$str = "abcdd";
proc($str);
