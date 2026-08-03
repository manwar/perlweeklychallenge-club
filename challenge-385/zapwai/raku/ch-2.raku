use v6;

sub proc($str) {
    say "Input: \$str = $str";
    my @out;
    my $cnt = 0;
    my $word = "";
    for $str.comb -> $c {
	if $cnt == 0 {
	    if $c eq '(' {
		$cnt++;
	    } else {
		say "Invalid Input!";
		return;
	    }
	} else {
	    $cnt-- if $c eq ')';
	    if $cnt == 0 {
		push @out, $word;
		$word = "";
		next;
	    }
	    $cnt++ if $c eq '(';
	    $word ~= $c;
	}
    }
    say "Output: ", @out.join('');
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
