use v5.30;

my @words = ("ab", "de", "ed", "bc");
my @words2 = ("aa", "ba", "cd", "ed");
my @words3 = ("uv", "qp", "st", "vu", "mn", "pq");

proc($_) foreach (\@words, \@words2, \@words3);

sub proc {
    my $ref = shift;
    my @words = @{$ref};
    say "Input: \@words = (" . join(", ", @words) . ")";
    my $cnt_of_pairs = 0;
    count_pairs(\$cnt_of_pairs, \@words);
    say "Output: $cnt_of_pairs";
}

sub count_pairs {
    my @words = @{$_[1]};
    foreach my $i1 (0 .. $#words - 1) {
	for my $i2 ($i1 + 1 .. $#words) {
	    if ($words[$i1] eq reverse $words[$i2]) {
		${$_[0]}++;
	    }
	}
    }
}
