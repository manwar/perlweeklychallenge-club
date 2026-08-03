use v5.38;

sub proc($str) {
    say "Input: \$str = $str";
    my @out;
    # Use a counter to keep track of nesting
    my $cnt = 0;
    my $word = "";
    for my $c (split '', $str) {
	if ($cnt == 0) {
	    if ($c eq '(') {
		$cnt++;
	    } else {
		say "Invalid Input!";
		return;
	    }
	} else {
	    $cnt-- if ($c eq ')');
	    if ($cnt == 0) {
		push @out, $word;
		$word = "";
		next;
	    }
	    $cnt++ if ($c eq '(');
	    $word .= $c;
	}
    }
    say "Output: ".@out;
}

my $str = "()()()";
proc($str);

$str = "(((())))";
proc($str);

$str = "(()())(())";
proc($str);

$str = "()((()))()";
proc($str);

$str = "(()(()))(()())";
proc($str);
