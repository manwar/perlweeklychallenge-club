use v5.38;
# return true if given words are anagrams
sub is_anagram($w1, $w2) {
    my @l1 = sort split "", $w1;
    my @l2 = sort split "", $w2;
    return 0 if (@l1 != @l2);
    for my $i (0 .. $#l1) {
	return 0 if ($l1[$i] ne $l2[$i]);
    }
    return 1;
}
sub proc(@words) {
    say "Input: \@words = @words";
    my $n;
    do {
	$n = 0;
	my @ind;
	for my $i (0 .. $#words - 1) {
	    if (is_anagram($words[$i], $words[$i+1])) {
		$n++;
		push @ind, $i;
		
	    }
	}
	for (reverse @ind) {
	    splice @words, $_, 1;
	}
    } while ($n);
    say "Output: ". scalar @words . " (@words)";
    
}
my @words = ("acca", "dog", "god", "perl", "repl");
proc(@words);
@words = ("abba", "baba", "aabb", "ab", "ab");
proc(@words);
