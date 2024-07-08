use v5.38;
my @words1 = ("Perl", "is", "my", "friend");
my @words2 = ("Perl", "and", "Raku", "are", "friend");
proc(\@words1, \@words2);
@words1 = ("Perl", "and", "Python", "are", "very", "similar");
@words2 = ("Python", "is", "top", "in", "guest", "languages");
proc(\@words1, \@words2);

sub proc($words1, $words2) {
    say "Input: @words1, @words2";
    my @words1 = @$words1;
    my @words2 = @$words2;
    my $cnt = 0;
    for my $word1 (@words1) {
	next if (is_multi($word1, @words1));
	for my $word2 (@words2) {
	    next if (is_multi($word2, @words2));
	    $cnt++ if ($word1 eq $word2);
	}
    }
    say "Output: $cnt";
}

#return true if $word occurs more than once in the list.
sub is_multi($word, @words) {
    my $cnt = 0;
    foreach my $w (@words) {
	$cnt++ if ($word eq $w);
    }
    return 0 if ($cnt == 1);
    return 1;
}
