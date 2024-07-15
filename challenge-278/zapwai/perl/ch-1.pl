use v5.38;
my $str = "and2 Raku3 cousins5 Perl1 are4";
proc($str);
$str = "guest6 Python1 most4 the3 popular5 is2 language7";
proc($str);
$str = "Challenge3 The1 Weekly2";
proc($str);

sub proc($str) {
    say "Input: $str";
    my @words;
    my @keys;
    for my $word (split " ", $str) {
	my $key = substr($word, -1);
	my $w = substr($word, 0, -1);
	push @words, $w;
	push @keys, $key;
    }
    my $cnt = 1;
    while ($cnt > 0) {
	$cnt = 0;
	for my $i (0 .. $#words - 1) {
	    if ($keys[$i] > $keys[$i + 1]) {
		my $keynum = $keys[$i];
		$keys[$i] = $keys[$i + 1];
		$keys[$i + 1] = $keynum;
		my $word = $words[$i];
		$words[$i] = $words[$i + 1];
		$words[$i + 1] = $word;
		$cnt++;
	    }
	}
    }
    say "Output: @words";
}
