use v5.36;
my $word = $ARGV[0] || "door";
say "Input: $word";
my @let = split "", $word;
my %words;
sub L {
    my ($k, $list) = @_;
    if ($k == 1) {
	$words{join("",@$list)} = 1;
    } else {
	L($k-1, $list);
	for my $i (0 .. $k-2) {
	    if ($k % 2 == 0) {
		swap($i, $k-1, $list);
	    } else {
		swap(0, $k-1, $list);
	    }
	    L($k-1,$list);
	}
    }
}
sub swap {
    my ($i, $j, $list) = @_;
    my $hold = $$list[$i];
    $$list[$i] = $$list[$j];
    $$list[$j] = $hold;
}

my $file = "/usr/share/dict/words";
open my $fh, "<", $file;
my @file = <$fh>;
close $fh;
L(length $word, \@let);
foreach my $keyword (keys %words){
    print grep { lc($_) =~ /^$keyword$/ } @file;
}
