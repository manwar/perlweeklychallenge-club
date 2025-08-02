use v5.38;
my $str = "pPeERrLl";
proc($str);
$str = "rRr";
proc($str);
$str = "GoO";
proc($str);
sub proc($str) {
    say "Input: $str";
    my @let = split "", $str;
    my $prev = "0";
    my $curr;
    my $cnt = -1;
    for my $i (0 .. -1 + length $str) {
	$curr = $let[$i];
	$cnt++ unless (lc $prev eq lc $curr);
	$prev = $curr;
    }
    say "Output: $cnt";
}
