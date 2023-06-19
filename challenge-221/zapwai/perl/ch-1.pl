use v5.30;
my @words1 = ("cat", "bt", "hat", "tree");
my $chars1 = "atach";
my @words2 = ("hello", "world", "challenge");
my $chars2 = "welldonehopper";
my @chars = ($chars1, $chars2);
my @ref = (\@words1, \@words2);
for (0 .. 1) {
    my $chars = $chars[$_];
    my @words = @{$ref[$_]};
    my @letters = split "", $chars;

    my $sum;
    foreach my $word (@words) {
	my @L = @letters;
	$sum += is_good($word, \@L);
    }

    say "Input: \@words = (" . join(",",@words) . ")";
    say " " x 7 . "\$chars = $chars";
    say "Output: $sum";

}
# return length of $word if W is contained in L, otherwise 0
sub is_good { 
    my ($word, $lref) = @_;
    my @L = @$lref;
    my @W = split "", $word;
    foreach my $w (@W) {
	my $len = $#L + 1;
	my $cnt = 0;
	for my $i (0 .. $#L) {
	    if ($L[$i] eq $w) {
		splice @L, $i, 1;
		last;
	    } else {
		$cnt++;
	    }
	}
	return 0 if ($cnt == $len);
    }
    return length $word;
}
