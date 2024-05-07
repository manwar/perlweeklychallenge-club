use v5.38;
my $alph = "abcdefghijklmnopqrstuvwxyz";

my $str = "abcdefghijklmnopqrstuvwxyz";
my @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
proc($str, @widths);

$str = "bbbcccdddaaa";
@widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
proc($str, @widths);

sub proc($str, @widths) {
    say "Input: $str";
    my $pixwidth = 100;
    my $width = $pixwidth;
    my $lines = 1;
    for my $s (split "", $str) {
	my $w = $widths[index $alph, $s];
	if ($width - $w < 0) {
	    $lines++;
	    $width = $pixwidth;
	}
	$width -= $w;
    }
    say "Output: ($lines, ", ($pixwidth - $width), ")";
}
