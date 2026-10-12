use v6;

# Return 1 if rows / cols are equal
# Return -1 if malformed (wrong dims), return 0 otherwise
sub check(@w) {
    my $len = @w[0].chars;
    my @A;
    for @w -> $word {
	my @word = $word.comb;
	push @A, @word;
    }
    for 0 .. $len - 1 -> $i {
	for 0 .. $len - 1 -> $j {
	    next if $j == $i;
	    return 0 if @A[$i][$j] ne @A[$j][$i];
	}
    }
    return 1;
}

sub proc(@words) {
    say "Input: "~ @words;
    my $len = @words[0].chars;
    say "Output: ";
    for @words.combinations: $len -> @c {
	for @c.permutations -> @p {
	    say "\t"~@p if check(@p) == 1;
	}
    }
}

my @words = ("MA", "AM", "MY", "ME");
proc(@words);
@words = ("SUN", "USE", "NET", "SEE", "TEN");
proc(@words);
@words = ("BOAT", "TEAL", "AREA", "TSAR", "OGRE");
proc(@words);
@words = ("CARD", "AREA", "REAR", "DART");
proc(@words);
@words = ("HEART", "TREND", "EMBER", "RESIN", "ABUSE");
proc(@words);
