use v5.38;

sub chip($s) {
    if ($s =~ /\W$/) {
	return substr $s, 0, length($s) - 1;
    }
    else {
	return $s;
    }
}
sub proc($sentence, $first, $second) {
    say "Input: \$sentence = $sentence\n\$first = $first\n\$second = $second";
    my @o;
    my @w = split ' ', $sentence;
    for my $i (0 .. $#w - 1) {
	my $word_one = $w[$i];
	my $word_two = $w[$i + 1];
	if ($word_one eq $first && $word_two eq $second) {
	    push @o, chip($w[$i + 2]);
	}
    }
    say "Output: @o";
}

my $sentence = "Perl is a my favourite language but Python is my favourite too.";
my $first = "my";
my $second = "favourite";
proc($sentence, $first, $second);

$sentence = "Barbie is a beautiful doll also also a beautiful princess.";
$first = "a";
$second = "beautiful";
proc($sentence, $first, $second);

$sentence = "we will we will rock you rock you.";
$first = "we";
$second = "will";
proc($sentence, $first, $second);
