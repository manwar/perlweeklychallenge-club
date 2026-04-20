use v5.38;

sub strip($w) {
    my $out;
    for my $letter (split '', $w) {
	$out .= $letter if ($letter =~ /\w/);
    }
    return $out;
}

sub proc($paragraph, @banned) {
    say "Input:  \$paragraph = $paragraph\n\t\@banned = @banned";
    my @words;
    if ($paragraph =~ /\s/) {
	@words = split ' ', lc $paragraph;
    } else {
	my $word;
	for my $letter (split '', lc $paragraph) {
	    if ($letter =~ /[a-zA-Z]/) {
		$word .= $letter;
	    } else {
		push @words, $word;
		$word = "";
	    }
	}
    }
    
    my %h;
    foreach my $word (@words) {
	$word = strip($word);
	$h{$word}++;
    }
    my $max = 0;
    my $max_word;
    for my $w (keys %h) {
	my $ban = 0;
	for my $banned_word (@banned) {
	    if ($w eq $banned_word) {
		$ban = 1;
		last;
	    }
	}
	next if ($ban);
	if ($max < $h{$w}) {
	    $max_word = $w;
	    $max = $h{$w};
	}
    }
    say "Output: $max_word";
}

my $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.";
my @banned = ("hit");
proc($paragraph, @banned);

$paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange.";
@banned = ("apple", "pear");
proc($paragraph, @banned);

$paragraph = "A. a, a! A. B. b. b.";
@banned = ("b");
proc($paragraph, @banned);

$paragraph = "Ball.ball,ball:apple!apple.banana";
@banned = ("ball");
proc($paragraph, @banned);

$paragraph = "The dog chased the cat, but the dog was faster than the cat.";
@banned = ("the", "dog");
proc($paragraph, @banned);
