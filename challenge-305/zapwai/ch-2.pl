use v5.38;
sub out_of_order($dict, $a, $b) {
    my @la = split '', $a;
    my @lb = split '', $b;
    my $N = (length $a < length $b) ? length $a : length $b;
    for my $i (0 .. $N - 1) {
	next if ($lb[$i] eq $la[$i]);
	my $ib = index $dict, $lb[$i];
	my $ia = index $dict, $la[$i];
	return ($ib < $ia) ? 1 : 0;
    }
}

sub alien($dict, $w) {
    my @words = @$w;
    my @list = @words;
    my $n = 0;
    do {
	$n = 0;
	for my $i (0 .. $#list - 1) {
	    if (out_of_order($dict, $list[$i], $list[$i+1])) {
		$n++;
		my $temp = $list[$i];
		$list[$i] = $list[$i + 1];
		$list[$i + 1] = $temp;
		last;
	    }
	}
    } while ($n != 0);
    return "@list";
}

sub proc($w, $a) {
    say "Input: words: @$w";
    say "\tdict: $a";
    say "Output: ", alien($a, $w);
}

my @words = ("perl", "python", "raku");
my @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/;
proc(\@words, join '', @alien);

@words = ("the", "weekly", "challenge");
@alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/;
proc(\@words, join '', @alien);
