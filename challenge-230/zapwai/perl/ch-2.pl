use v5.30;
my @words = ("pay", "attention", "practice", "attend");
my $prefix = "at";
my $len = length $prefix;
my @word;
foreach my $word (@words) {
    if (length $word <= $len) {
	push @word, $word;
    } else {
	push @word, substr $word, 0, $len;
    }
}
my $cnt;
foreach my $w (@word) {
    $cnt++ if ($w eq $prefix);
}
say "Input:\t \@words = (" . join(", ",@words) . ")";
say "\t \$prefix = $prefix";
say "Output: $cnt";
