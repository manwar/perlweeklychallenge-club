use v5.38;
use List::Util "uniq";

# Randomly append a letter, chose 0 to k-1, to the end.
sub append($s, $k) {
    my $r = int $k*rand;
    my $pre = substr $s, 0, $r;
    my $letter = substr $s, $r, 1;
    my $post = substr $s, $r + 1;
    return $pre.$post.$letter;
}

sub proc($str, $k) {
    say "Input: \$str = $str, \$k = $k";
    my @o;
    my $s = $str;
    for (0 .. 10000) {
	$s = append($s, $k);
	push @o, $s;
    }
    @o = uniq @o;
    @o = sort @o;
    my $out = $o[0];
    say "Output: $out";
}

my $str = "dbca"; my $k = 1;
proc($str, $k);
$str = "geeks"; $k = 2;
proc($str, $k);
$str = "cbaed"; $k = 3;
proc($str, $k);
$str = "fedcba"; $k = 4;
proc($str, $k);
$str = "perl"; $k = 1;
proc($str, $k);
