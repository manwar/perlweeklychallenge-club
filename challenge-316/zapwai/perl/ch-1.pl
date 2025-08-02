use v5.38;
sub proc(@list) {
    say "Input: \@list = @list";
    my $o = 1;
    for my $i (0 .. $#list - 1) {
	my $w1 = $list[$i];
	my $w2 = $list[$i + 1];
	my $a = substr $w1, length($w1) - 1, 1;
	my $b = substr $w2, 0, 1;
	$o = 0 if ($a ne $b);
    }
    say "Output: ", ($o == 1) ? 'true' : 'false';
}

my @list = ("perl", "loves", "scala");
proc(@list);
@list = ("love", "the", "programming");
proc(@list);
@list = ("java", "awk", "kotlin", "node.js");
proc(@list);
