use v5.38;

sub proc($str) {
    say "Input: $str";
    my $len = length($str)/2;
    my $first = lc(substr $str, 0, $len);
    my $second = lc(substr $str, $len);
    my ($first_cnt, $second_cnt) = (0, 0);
    for my $c (split '', $first) {
	if ($c =~ /[aeiou]/) {
	    $first_cnt++;
	}
    }
    for my $c (split '', $second) {
	if ($c =~ /[aeiou]/) {
	    $second_cnt++;
	}
    }
    my $o = ($first_cnt == $second_cnt) ? "true" : "false";
    say "Output: $o";
}

my $str = "textbook";
proc($str);
$str = "book";
proc($str);
$str = "AbCdEfGh";
proc($str);
$str = "rhythmmyth";
proc($str);
$str = "UmpireeAudio";
proc($str);
