use v5.38;
sub lexdist($a, $b) {
    my $alph = 'abcdefghijklmnopqrstuvwxyz';
    my $start = index $alph, $a;
    my $end = index $alph, $b;
    my $clockwise = abs($end - $start);
    my $counter;
    if ($a le $b) {
	$counter = $start + 26 - $end;
    } else {
	$counter = $end + 27 - $start;
    }
    $counter = abs($counter);
    return ($clockwise < $counter) ? $clockwise : $counter;
}

sub proc($str) {
    say "Input: \$str = $str";
    my $sum = length $str;
    my @l = split '', $str;
    for my $i (0 .. $#l - 1) {
	$sum += lexdist($l[$i], $l[$i+1]);
    }
    say "Output: $sum";
}
my $str = "abc";
proc($str);
$str = 'bza';
proc($str);
$str = 'zjpc';
proc($str);
