use v5.38;
use List::Util "min";
sub proc($s1, $s2, $s3) {
    say "Input: \$s1 = $s1, \$s2 = $s2, \$s3 = $s3";
    my $len = min(length $s1, length $s2, length $s3);
    my $common_length = 0;
    my $steps = 0;
    while ($common_length <= $len) {
	$common_length++;
	my $chunk1 = substr $s1, 0, $common_length;
	my $chunk2 = substr $s2, 0, $common_length;
	my $chunk3 = substr $s3, 0, $common_length;
	if ($chunk1 ne $chunk2 || $chunk1 ne $chunk3) {
	    $steps = -1 if ($common_length == 1);
	    $common_length--;
	    last;
	}
    }
    unless ($steps == -1) {
	for ($s1, $s2, $s3) {
	    $steps += length($_) - $common_length;
	}
    }
    say "Output: $steps";
}
my $s1 = "abc"; my $s2 = "abb"; my $s3 = "ab";
proc($s1, $s2, $s3);
$s1 = "ayz"; $s2 = "cyz"; $s3 = "xyz";
proc($s1, $s2, $s3);
$s1 = "yza"; $s2 = "yzb"; $s3 = "yzc";
proc($s1, $s2, $s3);
