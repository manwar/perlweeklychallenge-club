use v5.38;

sub rinse($str, @words) {
    my $word_cnt = 0;
    for my $word (@words) {
	$word_cnt++ if (grep /$word/, $str);
	my $len = length $word;
	my $s = index $str, $word;
	my $pre = substr $str, 0, $s;
	my $post = substr $str, $s+$len;
	$str = $pre.$post;
    }
    return -1 if ($word_cnt == 0);
    return $str;
}

sub proc($str, @words) {
    say "Input: str=$str, words={@words}";
    print "Output: ";
    $str = rinse($str, @words);
    while ($str) {
	$str = rinse($str, @words);
	last if ($str eq -1);
    }
    ($str) ? say "false" : say "true";
}

my $str = 'weeklychallenge'; my @words = ("challenge", "weekly");
proc($str, @words);
$str = "perlrakuperl"; @words = ("raku", "perl");
proc($str, @words);
$str = "sonsanddaughters"; @words = ("sons", "sand", "daughters");
proc($str, @words);

