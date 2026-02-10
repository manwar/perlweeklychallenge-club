use v5.38;

sub proc($str, $width) {
    say "Input: \$str = $str, \$width = $width";
    my $diff = $width - length($str);
    if ($diff < 0) {
	say "Error, length too short";
	return;
    }
    my $left_len = int($diff / 2);
    my $right_len = $diff - $left_len;
    say "*" x $left_len, $str, "*" x $right_len;
}

my $str = "Hi"; my $width = 5;
proc($str, $width);
$str = "Code"; $width = 10;
proc($str, $width);
$str = "Hello"; $width = 9;
proc($str, $width);
$str = "Perl"; $width = 4;
proc($str, $width);
$str = "A"; $width = 7;
proc($str, $width);
$str = ""; $width = 5;
proc($str, $width);
