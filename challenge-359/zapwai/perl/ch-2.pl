use v5.38;

# Check for duplicates
sub dup($word) {
    my $o = 0;
    my @l = split '', $word;
    for my $i (0 .. $#l - 1) {
	$o = 1 if ($l[$i] eq $l[$i+1]);
    }
    return $o;
}

sub proc($word) {
    say "Input: \$word = $word";
    my @ind;
    my @l = split '', $word;
    while (dup($word)) {
	my $flag = 0; # Avoids mistaken duplicates (e.g. aaaf only marks 0, not 0 and 1)
	for my $i (0 .. $#l - 1) {
	    if ($flag == 1) {
		$flag = 0;
		next;
	    }
	    if ($l[$i] eq $l[$i+1]) {
		push @ind, $i;
		$flag = 1;
	    }
	}
	say "@ind";
	for my $i (reverse @ind) {
	    splice @l, $i, 2;
	}
	@ind = ();
	$word = join '', @l;
    }
    say "Output: $word";
}

my $word = "aabbccdd";
proc($word);

$word = "abccba";
proc($word);

$word = "abcdef";
proc($word);

$word = "aabbaeaccdd";
proc($word);

$word = "mississippi";
proc($word);

$word = "aaafgh";
proc($word);
