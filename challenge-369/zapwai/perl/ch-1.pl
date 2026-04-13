use v5.38;

sub proc($caption) {
    say "Input: \$caption = $caption";
    my @word = split ' ', $caption;
    foreach my $i (0 .. $#word) {
	next unless($word[$i] =~ /\W|\d/);
	my $w;
	my @letter = split '', $word[$i];
	for my $i (0 .. $#letter) {
	    unless ($letter[$i] =~ /\d/) {
		$w .= $letter[$i] if ($letter[$i] =~ /\w/)
	    }
	}
	$word[$i] = $w;
    }
    my $s = "#";
    for my $i (0 .. $#word) {
	next unless ($word[$i]);
	if ($i == 0) {
	    $s .= lc($word[$i]);
	} else {
	    $s .= ucfirst($word[$i]);
	}
    }
    if (length($s) > 100) {
	$s = substr($s, 0, 100);
    }
    say "Output: $s";
}

my $caption = "Cooking with 5 ingredients!";
proc($caption);
$caption = "the-last-of-the-mohicans";
proc($caption);
$caption = "  extra spaces here";
proc($caption);
$caption = "iPhone 15 Pro Max Review";
proc($caption);
$caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!";
proc($caption);
