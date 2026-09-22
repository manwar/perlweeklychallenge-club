use v6;

sub value($word1, $word2) {
    return $word1.chars*$word2.chars;
}

sub letters_same($word1, $word2) {
    my @w1 = $word1.comb;
    my @w2 = $word2.comb;
    for @w1 -> $l1 {
	for @w2 -> $l2 {
	    return 1 if $l1 eq $l2;
	}
    }
    return 0;
}

sub proc(@words) {
    say "Input: " ~ @words ;
    my $max_val = 0;
    my ($outword1, $outword2);
    for 0 .. @words.end - 1 -> $i {
	for $i + 1 .. @words.end -> $j {
	    my $word1 = @words[$i];
	    my $word2 = @words[$j];
	    unless letters_same($word1, $word2) {
		my $value = value($word1, $word2);
		if $value > $max_val {
		    $max_val = $value;
		    ($outword1, $outword2) = ($word1, $word2);
		}
	    }
	}
    }
    say "Output: $max_val";
    say "\t$outword1, $outword2" unless $max_val == 0;
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
