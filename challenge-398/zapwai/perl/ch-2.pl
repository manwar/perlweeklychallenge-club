use v5.38;
my $alph = "abcdefghijklmnopqrstuvwxyz";

sub diff($s) {
    my @l = split '', $s;
    my @o;
    for my $i (0 .. $#l - 1) {
	my $l2 = index $alph, $l[$i+1];
	my $l1 = index $alph, $l[$i];
	push @o, $l2 - $l1;
    }
    return @o;
}

sub proc(@w) {
    say "Input: @w";
    my @wordstring;
    for my $word (@w) {
	my $ws = join ' ', diff($word);
	push @wordstring, $ws;
    }
    my $common;
    for my $i (0 .. $#wordstring - 1) {
	if ($wordstring[$i] eq $wordstring[$i+1]) {
	    $common = $wordstring[$i];
	    last;
	}
    }
    my $ind;
    for my $i (0 .. $#wordstring) {
	my $word = $wordstring[$i];
	next if ($word eq $common);
	$ind = $i;
	last;
    }
    my $out = $w[$ind];
    say "Output: $out";
}

my @words = ("ab", "bc", "cd", "zy");
proc(@words);
@words = ("cba", "fed", "azy");
proc(@words);
@words = ("pop", "ada", "beb", "cfc");
proc(@words);
@words = ("aaaa", "zzzz", "mmmm", "aaba");
proc(@words);
@words = ("aceg", "bdfh", "cegi", "azbz");
proc(@words);
