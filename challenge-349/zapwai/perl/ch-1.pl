use v5.38;

sub proc($str) {
    say "Input: $str";
    my $block_flag = 0;
    my $block_len = 1;
    my $max = ($str) ? 1 : 0; 
    my $prev_letter = "";
    for my $letter (split '', $str) {
	if ($prev_letter eq $letter) {
	    if ($block_flag) {
		$block_len++;
	    } else {
		$block_flag = 1;
		$block_len = 2;
	    }
	} else {
	    if ($block_flag) {
		$block_flag = 0;
		if ($max < $block_len) {
		    $max = $block_len;
		}
	    }
	}
	$prev_letter = $letter;
    }
    if ($max < $block_len) {
	$max = $block_len;
    }
    say "Output: $max";
}

my $str = "textbook";
proc($str);
$str = "aaaaa";
proc($str);
$str = "hoorayyy";
proc($str);
$str = "x";
proc($str);
$str = "aabcccddeeffffghijjk";
proc($str);
