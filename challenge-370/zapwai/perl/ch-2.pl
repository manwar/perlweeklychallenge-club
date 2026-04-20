use v5.38;

my $TRIALS = 10000;		# increase for more confidence :D

sub scramble($s) {
    my $len = length($s);
    if ($len == 1) {
	return $s;
    } else {
	my $pt = 1 + ($len - 1) * rand();
	my $a = substr $s, 0, $pt;
	my $b = substr $s, $pt;
	my $a_new = (int 2*rand() == 0) ? $a : scramble($a);
	my $b_new = (int 2*rand() == 0) ? $b : scramble($b);
	my $out = (int 2*rand() == 0) ? $a_new.$b_new : $b_new.$a_new;
    }
}

sub proc($str1, $str2)  {
    say "Input: \$str1 = $str1, \$str2 = $str2";
    my $cnt = 0;
    my $match = 0;
    while ($cnt < $TRIALS) {
	$cnt++;
	$match = 1 if (scramble($str1) eq $str2);
    }
    say "Output: ", ($match) ? "true" : "false";
}

my $str1 = "abc"; my $str2 = "acb";
proc($str1, $str2);
$str1 = "abcd"; $str2 = "cdba";
proc($str1, $str2);
$str1 = "hello"; $str2 = "hiiii";
proc($str1, $str2);
$str1 = "ateer"; $str2 = "eater";
proc($str1, $str2);
$str1 = "abcdefgh"; $str2 = "abcefghd";
proc($str1, $str2);
