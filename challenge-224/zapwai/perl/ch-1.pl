use v5.30;
my $src1 = "abc";
my $tar1 = "xyz";
my $src2 = "scriptinglanguage";
my $tar2 = "perl";
my $src3 = "aabbcc";
my $tar3 = "abc";
my @src = ($src1, $src2, $src3);
my @tar = ($tar1, $tar2, $tar3);
for my $i (0 .. 2) {
    my $src = $src[$i];
    my $tar = $tar[$i];    
    my @l = split("", $src);
    my %h;
    $h{$_}++ for @l;
    my @L = split "", $tar;
    my $fail = 0;
    foreach my $l (@L) {
	if ($h{$l} > 0) {
	    $h{$l}--;
	} else {
	    $fail = 1;
	}
    }
    say "Input:  \$source = $src\n\t\$target = $tar";
    my $out = ($fail == 1) ? "False" : "True";
    say "Output: $out\n";
}
