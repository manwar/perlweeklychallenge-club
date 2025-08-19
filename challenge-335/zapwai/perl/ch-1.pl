use v5.38;

sub word_intersection($w1, $w2) {
    my @l1 = sort split '', $w1;
    my @l2 = sort split '', $w2;
    my @o;
    for my $i (0 .. $#l1) {
	my $letter = $l1[$i];
	for my $j (0 .. $#l2) {
	    my $oletter = $l2[$j];
	    if ($letter eq $oletter) {
		push @o, $letter;
		splice @l2, $j, 1;
		last;
	    }
	}
    }
    return join '', @o;
}

sub proc(@words) {
    say "Input : @words";
    my $shared = $words[0];
    for my $i (1 .. $#words) {
	$shared = word_intersection($shared, $words[$i]);
    }
    say "Output: $shared";
}

my @words = ("bella", "label", "roller");
proc(@words);

@words = ("cool", "lock", "cook");
proc(@words);
@words = ("hello", "world", "pole");
proc(@words);
@words = ("abc", "def", "ghi");
proc(@words);
@words = ("aab", "aac", "aaa");
proc(@words);
