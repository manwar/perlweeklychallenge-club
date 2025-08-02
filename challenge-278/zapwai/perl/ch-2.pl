use v5.38;
my $str = "challenge";
my $char = "e";
proc($str, $char);
$str = "programming";
$char = "a";
proc($str, $char);
$str = "champion";
$char = "b";
proc($str, $char);
sub proc($str, $char) {
    say "Input: \$str = $str, \$char = $char";
    my $ind = index($str, $char);
    if ($ind == -1) {
	say "Output: $str";
    } else {
	my $begin = substr($str, 0, $ind + 1);
	my $end = substr($str, $ind + 1);
	say arrange($begin) , $end;
    }
}
sub arrange($word) {
    my @arr = split "", $word;
    return sort @arr;
}
