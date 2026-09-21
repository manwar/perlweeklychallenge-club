use v5.38;

sub value($word1, $word2) {
    return length($word1)*length($word2);
}

sub letters_same($word1, $word2) {
    my @w1 = split '', $word1;
    my @w2 = split '', $word2;
    for my $l1 (@w1) {
	for my $l2 (@w2) {
	    return 1 if ($l1 eq $l2);
	}
    }
    return 0;
}

sub proc(@words) {
    say "Input: @words";
    my $max_val = 0;
    my ($outword1, $outword2);
    for my $i (0 .. $#words - 1) {
	for my $j ($i + 1 .. $#words) {
	    my $word1 = $words[$i];
	    my $word2 = $words[$j];
	    unless (letters_same($word1, $word2)) {
		my $value = value($word1, $word2);
		if ($value > $max_val) {
		    $max_val = $value;
		    ($outword1, $outword2) = ($word1, $word2);
		}
	    }
	}
    }
    say "Output: $max_val";
    say "\t$outword1, $outword2" unless ($max_val == 0);
}

my @words = ("a", "ab", "abc", "d", "de", "def");
proc(@words);
@words = ("a", "aa", "aaa", "aaaa");
proc(@words);
@words = ("meet", "app", "code", "sky", "bold");
proc(@words);
@words = ("a", "ab", "abc", "abcd", "efghi");
proc(@words);
@words = ("xyz", "w", "abcdefg", "hij");
proc(@words);
