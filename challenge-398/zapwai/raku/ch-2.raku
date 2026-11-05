use v6;
my $alph = "abcdefghijklmnopqrstuvwxyz";

sub diff($s) {
    my @l = $s.comb;
    my @o;
    for 0 .. @l.end - 1 -> $i {
	my $l2 = index $alph, @l[$i+1];
	my $l1 = index $alph, @l[$i];
	push @o, $l2 - $l1;
    }
    return @o;
}

sub proc(@w) {
    say "Input: " ~ @w;
    my @wordstring;
    for @w -> $word {
	my $ws = diff($word).join(' ');
	@wordstring.push($ws);
    }
    my $common;
    for 0 .. @wordstring.end - 1 -> $i {
	if @wordstring[$i] eq @wordstring[$i+1] {
	    $common = @wordstring[$i];
	    last;
	}
    }
    my $ind;
    for 0 .. @wordstring.end -> $i {
	my $word = @wordstring[$i];
	next if $word eq $common;
	$ind = $i;
	last;
    }
    my $out = @w[$ind];
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
