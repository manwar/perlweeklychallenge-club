use v5.38;
my $alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";

sub value($v) {
    return $v if ($v =~ /\d/);
    my $value = 10 + index($alph, $v);
    return $value;
}

sub proc($num, $b) {
    say "Input: $num";
    my $sum = 0;
    my @v = split '', reverse $num;
    for my $i (0 .. $#v) {
	my $mult = $b**$i;
	my $val = value($v[$i]);
	$sum += $val*$mult;
    }
    say "Output: $sum";
}

my $num = "101010"; my $b = 2;
proc($num, $b);

$num = "EEADEE"; $b = 16;
proc($num, $b);

$num = "755"; $b = 8;
proc($num, $b);

$num = "1BRJB"; $b = 36;
proc($num, $b);

$num = "7MyqL"; $b = 64;
proc($num, $b);
