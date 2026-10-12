use v5.38;
use Algorithm::Permute;
use Algorithm::Combinatorics "combinations";

# Return 1 if rows / cols are equal
# Return -1 if malformed (wrong dims), return 0 otherwise
sub check(@w) {
    my $len = length($w[0]);
    return -1 if (@w != $len);
    my @A;
    for my $word (@w) {
	my @word = split '', $word;
	push @A, \@word;
    }
    for my $i (0 .. $len - 1) {
	for my $j (0 .. $len - 1) {
	    next if ($j == $i);
	    return 0 if ($A[$i][$j] ne $A[$j][$i]);
	}
    }
    return 1;
}

sub proc(@words) {
    say "Input: @words";
    my $len = length $words[0];
    my $citer = combinations(\@words, $len);
    say "Output: ";
    while (my $c = $citer->next) {
	my $piter = Algorithm::Permute->new($c);
	while (my @p = $piter->next) {
	    say "\t@p"
		if (check(@p) == 1);
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
