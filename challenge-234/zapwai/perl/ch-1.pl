use v5.30;
no warnings;
my @words = ("java", "javascript", "julia");
my @letters = split "", $words[0];
foreach my $word (@words) {
    my @l = split "", $word;
    foreach my $l (0 .. $#letters) {
	# remove from letters if item is not also in word.
	splice @letters, $l, 1 unless ($letters[$l] ~~ @l);
    }
}
my %ans;
$ans{$_} = 1 for (@letters);
my @ans = keys %ans;
say "Input: \@words = @words";
say "Output: @ans";
