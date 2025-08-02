use v5.38;

sub is_vowel_word($w) {
    $w = lc($w);
    my $first = substr $w, 0, 1;
    my $last = substr $w, -1, 1;
    if ($first =~ /[aeiou]/ || $last =~ /[aeiou]/) {
	return 1;
    } 
    0
}

sub proc(@l) {
    say "Input: @l";
    my $cnt = 0;
    for my $word (@l) {
	$cnt++ if (is_vowel_word($word));
    }
    say "Output: $cnt";
}

my @list = ("unicode", "xml", "raku", "perl");
proc(@list);

@list = ("the", "weekly", "challenge");
proc(@list);

@list = ("perl", "python", "postgres");
proc(@list);

